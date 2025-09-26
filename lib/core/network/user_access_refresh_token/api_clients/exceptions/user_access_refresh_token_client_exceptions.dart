abstract class UserAccessRefreshTokenClientExceptions implements Exception {
  final String message;

  UserAccessRefreshTokenClientExceptions(String message)
    : message = "UserAccessRefreshTokenClientException: $message";
}

class UserAccessRefreshTokenClientException
    extends UserAccessRefreshTokenClientExceptions {
  UserAccessRefreshTokenClientException(super.message);
}
