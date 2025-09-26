import 'package:result_dart/result_dart.dart';

abstract class IRedirectRuleServices {
  AsyncResult<String> appRedirectRule(Uri targetUri);
}
