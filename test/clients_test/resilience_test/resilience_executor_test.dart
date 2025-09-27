import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:imove_challenge/core/services/resilience/resilience_executor.dart';

Future<Object> asyncError() {
  throw Exception('Error');
}

void main() {
  group('ResilientExecutor', () {
    late ResilientExecutor executor;
    late int attemptCount;
    late List<Exception> retryErrors;
    late List<Exception> errorErrors;
    late Completer<void> operationCompleter;

    setUp(() {
      attemptCount = 0;
      retryErrors = [];
      errorErrors = [];
      operationCompleter = Completer<void>();
      executor = ResilientExecutor(
        initialDelay: Duration.zero, // No delay for tests
      );
    });

    test('executes successful operation without retries', () async {
      final result = executor.execute(
        () async => 'success',
        onRetry: (error, attempt) async {
          retryErrors.add(error);
        },
        onError: (error) async {
          errorErrors.add(error);
        },
      );

      final resultValue = await result.valueOrCancellation();

      expect(resultValue, equals('success'), reason: 'Result should be success');
      expect(retryErrors, isEmpty, reason: 'Retry errors should be empty');
      expect(errorErrors, isEmpty, reason: 'Error errors should be empty');
    });

    test('retries operation on failure and eventually succeeds', () async {
      final result = executor.execute(
        () async {
          attemptCount++;
          if (attemptCount < 3) {
            throw Exception('Attempt $attemptCount failed');
          }
          return 'success';
        },
        onRetry: (error, attempt) async {
          retryErrors.add(error);
        },
        onError: (error) async {
          errorErrors.add(error);
        },
      );

      final resultValue = await result.valueOrCancellation();

      expect(resultValue, equals('success'), reason: 'Result should be success');
      expect(attemptCount, equals(3), reason: 'Attempt count should be 3');
      expect(retryErrors.length, equals(2), reason: 'Retry errors should be 2');
      expect(errorErrors, isNotEmpty, reason: 'Error errors should be not empty');
    });

    test('calls onError when max attempts are exhausted', () async {
      try {
        final result = executor.execute(
          () {
            attemptCount++;
            throw Exception('Attempt $attemptCount failed');
          },
          onRetry: (error, attempt) async {
            retryErrors.add(error);
          },
          onError: (error) async {
            errorErrors.add(error);
          },
        );
        await result.valueOrCancellation();
        fail('Should have thrown an exception');
      } catch (e) {
        expect(e, isA<Exception>(), reason: 'Exception should be thrown');
        expect(attemptCount, equals(3), reason: 'Attempt count should be 3');
        expect(retryErrors.length, equals(2), reason: 'Retry errors should be 2');
        expect(errorErrors.length, equals(3), reason: 'Error errors should be 1');
      }
    });

    test('respects retryIf condition', () async {
      try {
        final result = executor.execute(
          () {
            attemptCount++;
            throw Exception('Attempt $attemptCount failed');
          },
          retryIf: (error) => attemptCount < 2, // Only retry once
          onRetry: (error, attempt) async {
            retryErrors.add(error);
          },
          onError: (error) async {
            errorErrors.add(error);
          },
        );
        await result.valueOrCancellation();
        fail('Should have thrown an exception');
      } catch (e) {
        expect(e, isA<Exception>(), reason: 'Exception should be thrown');
        expect(attemptCount, equals(2), reason: 'Attempt count should be 2');
        expect(retryErrors.length, equals(1), reason: 'Retry errors should be 1');
        expect(errorErrors.length, equals(2), reason: 'Error errors should be 2');
      }
    });

    test('can be cancelled during execution', () async {
      final cancelable = executor.execute(
        () async {
          await operationCompleter.future;
          return 'success';
        },
        onRetry: (error, attempt) async {
          retryErrors.add(error);
        },
        onError: (error) async {
          errorErrors.add(error);
        },
      );

      // Cancel the operation
      cancelable.cancel();

      try {
        await cancelable.valueOrCancellation();
        fail('Should have thrown an exception');
      } catch (e) {
        expect(e, isA<Exception>(), reason: 'Exception should be thrown');
        expect(retryErrors, isEmpty, reason: 'Retry errors should be empty');
        expect(errorErrors, isEmpty, reason: 'Error errors should be empty');
      }
    });

    test('can be cancelled during retry', () async {
      final cancelable = executor.execute(
        () async {
          attemptCount++;
          if (attemptCount < 3) {
            await operationCompleter.future;
            throw Exception('Attempt $attemptCount failed');
          }
          return 'success';
        },
        onRetry: (error, attempt) async {
          retryErrors.add(error);
        },
        onError: (error) async {
          errorErrors.add(error);
        },
      );

      // Cancel during retry
      cancelable.cancel();

      try {
        await cancelable.valueOrCancellation();
        fail('Should have thrown an exception');
      } catch (e) {
        expect(e, isA<Exception>(), reason: 'Exception should be thrown');
        expect(retryErrors.length, lessThan(2), reason: 'Retry errors should be less than 2');
        expect(errorErrors, isEmpty, reason: 'Error errors should be empty');
      }
    });

    test('handles non-Exception errors', () async {
      try {
        final result = executor.execute(
          () {
            attemptCount++;
            throw Exception('String error');
          },
          onRetry: (error, attempt) async {
            retryErrors.add(error);
          },
          onError: (error) async {
            errorErrors.add(error);
          },
        );
        await result.valueOrCancellation();
        fail('Should have thrown an exception');
      } catch (e) {
        expect(e, isA<Exception>(), reason: 'Exception should be thrown');
        expect(attemptCount, equals(3), reason: 'Attempt count should be 3');
        expect(retryErrors.length, equals(2), reason: 'Retry errors should be 2');
        expect(errorErrors.length, equals(3), reason: 'Error errors should be 1');
      }
    });

    test('executes sync operations with retries', () {
      try {
        executor.executeSync(
          () {
            attemptCount++;
            if (attemptCount < 3) {
              throw Exception('Attempt $attemptCount failed');
            }
            return 'success';
          },
          retryIf: (error) => true,
          onRetry: (error) {
            retryErrors.add(error);
          },
        );
        fail('Should have thrown an exception');
      } catch (e) {
        expect(e, isA<Exception>(), reason: 'Exception should be thrown');
        expect(attemptCount, equals(3), reason: 'Attempt count should be 3');
        expect(retryErrors.length, equals(2), reason: 'Retry errors should be 2');
      }
    });
  });

  group('ResilientExecutorStream', () {
    late ResilientExecutor executor;
    late int retriesCount;
    late List<Exception> retryErrors;
    late List<Exception> errorErrors;
    late int maxRetries;

    final testException = Exception('Error');

    setUp(() {
      retriesCount = 0;
      retryErrors = [];
      errorErrors = [];
      maxRetries = 3;
      executor = ResilientExecutor(
        initialDelay: Duration.zero, // No delay for tests
        maxDelay: Duration.zero,
      );
    });

    test('executes stream with no errors', () {
      final stream = executor.executeStream(
        () async* {
          yield 1;
          yield 2;
          yield 3;
        },
        onRetry: (error, attempt) async {
          retriesCount++;
        },
        onError: (error) async {
          errorErrors.add(error);
        },
      );
      expect(stream, emitsInOrder([1, 2, 3]));
      expect(retriesCount, equals(0));
      expect(retryErrors, isEmpty);
      expect(errorErrors, isEmpty);
    });

    test('retries stream with errors', () async {
      final stream = executor.executeStream(() async* {
        retriesCount++;
        yield 1;
        yield 2;
        if (retriesCount < maxRetries) {
          yield* Stream<int>.error(testException);
        } else {
          yield 3;
        }
      });
      final values = await stream.toList();
      expect(values, equals([1, 2, 1, 2, 1, 2, 3]));
    });

    test('should throw when maximum retries are reached', () {
      final stream = executor.executeStream(() async* {
        yield 1;
        yield 2;
        yield* Stream<int>.error(testException);
      });
      expect(() => stream.toList(), throwsA(isA<Exception>()));
    });

    test('should exhaust maxAttempts before throwing', () async {
      final stream = executor.executeStream(
        () async* {
          yield 1;
          yield 2;
          yield* Stream<int>.error(testException);
        },
        onError: (error) async {
          errorErrors.add(error);
        },
        onRetry: (error, attempt) async {
          retriesCount++;
        },
      );
      await stream.toList().catchError((error) => <int>[]);
      expect(retriesCount, equals(maxRetries - 1));
      expect(errorErrors, equals([testException]));
    });
  });
}
