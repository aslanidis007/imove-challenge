import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import '../../services/debug/log_service.dart';

extension DioCacheExtension on Dio {
  void configureRetryInterceptor({
    int retries = 3,
    List<Duration> retryDelays = const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3),
    ],
  }) {
    // Add the RetryInterceptor to Dio's interceptors.
    // The interceptor will retry failed requests based on the settings below.
    interceptors.add(
      RetryInterceptor(
        dio: this,
        // Optional: Use logPrint to log retry attempts.
        logPrint: (msg) => kLog.i(msg),
        // Maximum number of retry attempts.
        retries: retries,
        // Specify a list of delays before each retry attempt.
        // Here we define an increasing delay (exponential backoff-like).
        retryDelays: retryDelays,
        // Optional: Define a retry evaluator to control which errors trigger a retry.
        // For example, you might want to avoid retrying on HTTP 429 (Too Many Requests).
        retryEvaluator: (error, attempt) {
          // Don't retry if the status code is 429.
          return error.response?.statusCode != 429;
        },
      ),
    );
  }
}
