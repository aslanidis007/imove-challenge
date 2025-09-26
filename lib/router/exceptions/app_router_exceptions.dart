abstract class AppRouterException implements Exception {
  final String message;

  AppRouterException({required this.message});
}

class AppRouterRedirectException extends AppRouterException {
  AppRouterRedirectException() : super(message: "Router Redirect Exception");
}

class UserRedirectConditionsNotMetException extends AppRouterException {
  UserRedirectConditionsNotMetException()
    : super(message: "User Redirect Conditions Not Met Exception");
}
