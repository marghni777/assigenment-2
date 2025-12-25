import 'user.dart';

// A simple class to represent the result of the login operation
class LoginResult {
  final bool isSuccess;
  final User? user;
  final String? errorMessage;

  LoginResult.success(this.user)
      : isSuccess = true,
        errorMessage = null;

  LoginResult.failure(this.errorMessage)
      : isSuccess = false,
        user = null;
}
