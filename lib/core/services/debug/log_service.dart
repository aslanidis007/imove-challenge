import 'dart:developer';

import 'package:logger/logger.dart';

class MyPrinter extends PrettyPrinter {
  MyPrinter()
    : super(
        methodCount: 0,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: false,
      );

  @override
  List<String> log(LogEvent event) {
    // Do something if necessary
    return super.log(event);
  }
}

class DeveloperConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    final StringBuffer buffer = StringBuffer();
    event.lines.forEach(buffer.writeln);
    log(buffer.toString());
  }
}

final Logger kLog = Logger(
  printer: MyPrinter(),
  output: DeveloperConsoleOutput(),
);

class TesterConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    final StringBuffer buffer = StringBuffer();
    event.lines.forEach(buffer.writeln);
    print(buffer);
  }
}

final Logger kLogTester = Logger(
  printer: MyPrinter(),
  output: TesterConsoleOutput(),
);
