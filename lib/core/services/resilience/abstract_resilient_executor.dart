import 'dart:async';

import 'package:async/async.dart';

abstract class IResilientExecutor {
  CancelableOperation<T> execute<T>(
    Future<T> Function() operation, {
    bool Function(dynamic error)? retryIf,

    /// The onRetry callback now takes the encountered [Exception] and the current attempt count.
    Future<void> Function(Exception error, int attempt)? onRetry,

    /// The onError callback now takes the encountered [Exception].
    Future<void> Function(Exception error)? onError,

    /// The onAllRetriesError callback now takes the encountered [Exception].
    Future<void> Function(Exception error)? onAllRetriesError,
  });

  Stream<T> executeStream<T extends Object>(
    Stream<T> Function() streamFactory, {
    bool Function(dynamic error)? retryIf,

    /// The onRetry callback now takes the encountered [Exception] and the current attempt count.
    Future<void> Function(Exception error, int attempt)? onRetry,

    /// The onError callback now takes the encountered [Exception].
    Future<void> Function(Exception error)? onError,

    /// The onAllRetriesError callback now takes the encountered [Exception].
    Future<void> Function(Exception error)? onAllRetriesError,
  });

  T executeSync<T>(
    T Function() operation, {
    bool Function(dynamic error)? retryIf,
    void Function(Exception)? onRetry,
  });
}
