import 'package:flutter/material.dart';
import 'login_service.dart';
import 'login_result.dart';

void main() {
  // Since this is a console-based demonstration of the logic, 
  // we'll call the test function directly.
  // In a real Flutter app, you would call this from a UI event.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 2 Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('DummyJSON Login Demo')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Check the console for login results.'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _runLoginTests,
                child: const Text('Run Login Tests'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _runLoginTests() async {
  final loginService = LoginService();

  // --- Test Case 1: Successful Login ---
  print('--- Attempting Successful Login (emilys/emilyspass) ---');
  // Use a valid user from DummyJSON
  LoginResult successResult = await loginService.login('emilys', 'emilyspass');

  if (successResult.isSuccess) {
    print('RESULT: SUCCESS! Logged in as ${successResult.user!.firstName} ${successResult.user!.lastName}');
    // Logic for success: Navigate to home screen, save token, etc.
  } else {
    print('RESULT: FAILURE! Error: ${successResult.errorMessage}');
    // Logic for failure: Show error dialog
  }

  print('\n' + '=' * 50 + '\n');

  // --- Test Case 2: Failed Login ---
  print('--- Attempting Failed Login (invalid_user/wrong_password) ---');
  // Use invalid credentials
  LoginResult failureResult = await loginService.login('invalid_user', 'wrong_password');

  if (failureResult.isSuccess) {
    print('RESULT: SUCCESS! Logged in as ${failureResult.user!.firstName}');
  } else {
    print('RESULT: FAILURE! Error: ${failureResult.errorMessage}');
    // Logic for failure: Show error dialog
  }
}
