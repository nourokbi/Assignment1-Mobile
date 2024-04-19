// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoginSuccessful = false;

  Future<void> _loginUser() async {
    // Replace this with your actual login logic (e.g., API call)
    // Simulate successful login for this example
    await Future.delayed(const Duration(seconds: 1));
    if (_usernameController.text == "user" &&
        _passwordController.text == "password") {
      setState(() {
        _isLoginSuccessful = true;
      });
    } else {
      setState(() {
        _isLoginSuccessful = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                      ),
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/signup')},
                      child: const Text('Signup')),
                  SizedBox(width: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                      ),
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/edit-profile')},
                      child: const Text('Edit Profile')),
                ],
              ),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true, // Hide password input
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginUser,
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              Text(
                _isLoginSuccessful ? 'Login Successful' : 'Login Failed',
                style: TextStyle(
                    color: _isLoginSuccessful ? Colors.green : Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
