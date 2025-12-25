import 'package:dio/dio.dart';
import 'user.dart';
import 'login_result.dart';

class LoginService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://dummyjson.com/auth/login';

  // The core function to perform the login
  Future<LoginResult> login(String username, String password) async {
    try {
      // 1. Log in existing user (POST request)
      final response = await _dio.post(
        _baseUrl,
        data: {
          'username': username,
          'password': password,
          // 'expiresInMins': 30, // Optional parameter
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // 2. Handle Success result (HTTP Status 200)
      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        print('Login Successful! User: ${user.username}');
        print('Access Token: ${user.accessToken}');
        return LoginResult.success(user);
      }

      // Fallback for unexpected non-200 success codes
      return LoginResult.failure('Unexpected status code: ${response.statusCode}');

    } on DioException catch (e) {
      // 3. Handle Failure result (DioException)
      
      // Check for a response from the server (e.g., 400, 401, 404)
      if (e.response != null) {
        final errorData = e.response!.data;
        String message = 'Login failed.';

        // DummyJSON returns an error message in the body for failed login
        if (errorData != null && errorData is Map<String, dynamic> && errorData.containsKey('message')) {
          message = errorData['message'];
        } else {
          message = 'Server error: Status ${e.response!.statusCode}';
        }
        
        print('Login Failed: $message');
        return LoginResult.failure(message);
      } 
      
      // Handle network-related errors (e.g., no internet connection, timeout)
      else {
        String networkError = 'Network Error: Could not connect to the server.';
        print(networkError);
        return LoginResult.failure(networkError);
      }
    } catch (e) {
      // Handle any other unexpected errors
      print('An unknown error occurred: $e');
      return LoginResult.failure('An unknown error occurred.');
    }
  }
}
