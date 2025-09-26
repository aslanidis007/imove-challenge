import 'dart:async';

import 'package:result_dart/result_dart.dart';

extension StreamExtensions<T extends Object, E extends Exception> on Stream<T> {
  Stream<ResultDart<T, E>> toResultStream() {
    return transform(
      StreamTransformer.fromHandlers(
        handleData: (event, sink) => sink.add(Success<T, E>(event)),
        handleError: (error, stackTrace, sink) =>
            sink.add(Failure<T, E>(error as E)),
      ),
    );
  }
}
