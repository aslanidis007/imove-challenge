// ignore_for_file: unnecessary_type_check

import 'dart:async';
import 'dart:io';

import 'package:async/async.dart';
import 'package:imove_challenge/core/utils/extensions/stream_extensions.dart';
import 'package:retry/retry.dart';

import 'abstract_resilient_executor.dart';

/// A custom executor that provides retry logic with exponential backoff and
/// supports cancellation of the operation.

class ResilientExecutor implements IResilientExecutor {
  /// The maximum number of attempts (including the initial attempt).
  final int maxAttempts;

  /// The initial delay before the first retry attempt.
  final Duration initialDelay;

  /// The multiplier for exponential backoff.
  final double multiplier;

  /// The maximum delay between retry attempts.
  final Duration maxDelay;

  /// Internal retry options configured with the above parameters.
  final RetryOptions _retryOptions;

  /// Constructs a [ResilientExecutor] with the specified configuration.
  ///
  /// [maxAttempts]: Total number of attempts (initial attempt plus retries).
  /// [initialDelay]: The base delay before the first retry.
  /// [multiplier]: The factor to multiply the delay after each failed attempt.
  /// [maxDelay]: The maximum delay between attempts.
  ResilientExecutor({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.multiplier = 2.0,
    this.maxDelay = const Duration(seconds: 30),
  }) : _retryOptions = RetryOptions(
         maxAttempts: maxAttempts,
         delayFactor: initialDelay,
         // The [retry] package uses delayFactor as the base duration.
         // For exponential backoff, it multiplies the delay on each attempt.
         maxDelay: maxDelay,
       );

  @override
  CancelableOperation<T> execute<T>(
    Future<T> Function() operation, {
    bool Function(dynamic error)? retryIf,

    /// The onRetry callback now takes the encountered [Exception] and the current attempt count.
    Future<void> Function(Exception error, int attempt)? onRetry,
    Future<void> Function(Exception error)? onError,
    Future<void> Function(Exception error)? onAllRetriesError,
  }) {
    int attemptCount = 0;
    bool allRetriesErrorCalled = false;
    Exception? lastError;

    // Wrap the onRetry callback so that the attempt counter is incremented each time.
    Future<void> wrappedOnRetry(Exception error) async {
      lastError = error;
      attemptCount++;
      if (onRetry != null) {
        await onRetry(error, attemptCount);
      }
    }

    final retryFuture = _retryOptions
        .retry(
          () async {
            try {
              final result = await operation();
              return result;
            } on Exception catch (e) {
              // Call onError for every exception
              if (onError != null) {
                await onError(e);
              }
              // Re-throw to let the retry mechanism handle it
              rethrow;
            }
          },
          // By default, retry if the error is an Exception.
          retryIf: retryIf ?? (error) => error is Exception,
          onRetry: wrappedOnRetry,
        )
        .catchError((Object error) {
          // After all retries are exhausted, call onAllRetriesError if we have a last error
          if (error is Exception &&
              lastError != null &&
              onAllRetriesError != null &&
              !allRetriesErrorCalled) {
            allRetriesErrorCalled = true;
            return onAllRetriesError(lastError!).then((_) => throw error);
          }
          throw error;
        });

    return CancelableOperation<T>.fromFuture(retryFuture);
  }

  @override
  T executeSync<T>(
    T Function() operation, {
    bool Function(dynamic error)? retryIf,
    void Function(Exception)? onRetry,
    void Function(Exception)? onError,
  }) {
    int attemptCount = 0;
    // Default: do not retry any error unless a predicate is provided.
    final shouldRetry = retryIf ?? (error) => false;
    // Default onRetry callback does nothing.
    void defaultOnRetry(Exception error) {}
    final retryCallback = onRetry ?? defaultOnRetry;

    // Use instance variables from ResilientExecutor.
    Duration currentDelay = initialDelay;

    while (true) {
      try {
        return operation();
      } on Exception catch (error) {
        if (onError != null) {
          onError(error);
        }
        // If the error should not be retried or max attempts have been reached, rethrow.
        if (!shouldRetry(error) || attemptCount >= maxAttempts - 1) {
          rethrow;
        }
        if (error is Exception) {
          retryCallback(error);
        }
        // Block execution for the computed delay.
        sleep(currentDelay);
        attemptCount++;
        // Exponential backoff: increase delay with multiplier, capped at maxDelay.
        final nextDelayMicroseconds = (currentDelay.inMicroseconds * multiplier).toInt();
        currentDelay = Duration(microseconds: nextDelayMicroseconds);
        if (currentDelay > maxDelay) {
          currentDelay = maxDelay;
        }
      }
    }
  }

  @override
  Stream<T> executeStream<T extends Object>(
    Stream<T> Function() streamFactory, {
    bool Function(dynamic error)? retryIf,
    Future<void> Function(Exception error, int attempt)? onRetry,
    Future<void> Function(Exception error)? onError,
    Future<void> Function(Exception error)? onAllRetriesError,
    int attempt = 1,
  }) async* {
    // Wait for the delay duration before executing the streamFactory
    await Future.delayed(_retryOptions.delay(attempt - 1));

    // Convert the stream to a result stream
    final stream = streamFactory().toResultStream();

    // Listen to the stream
    await for (final event in stream) {
      if (event.isSuccess()) {
        // If the event is a success, yield the value
        yield event.getOrNull()!;
        continue;
      }
      onError?.call(event.exceptionOrNull() ?? Exception());

      final nextAttempt = attempt + 1;

      // Check if the error should be retried (if the retryIf predicate is provided or if the attempt count is greater than the maxAttempts)
      final shouldRetry = retryIf?.call(event.exceptionOrNull()) ?? nextAttempt <= maxAttempts;

      if (shouldRetry) {
        // Retry the stream
        onRetry?.call(event.exceptionOrNull() ?? Exception(), nextAttempt);
        yield* executeStream(
          streamFactory,
          retryIf: retryIf,
          onRetry: onRetry,
          onAllRetriesError: onAllRetriesError,
          onError: attempt == 1 ? onAllRetriesError : onError,
          attempt: nextAttempt,
        );
        break;
      } else {
        // If the error should not be retried, yield the error value (will essentially throw the error)
        final error = event.exceptionOrNull() ?? Exception();
        yield* Stream<T>.error(error);
      }
    }
  }
}
