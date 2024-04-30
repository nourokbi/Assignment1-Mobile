// ignore_for_file: library_private_types_in_public_api, unused_local_variable, unnecessary_null_comparison

import 'package:demo/models/constants.dart';
import 'package:demo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:demo/screens/profile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoginSuccessful = false;
  String? _errorMessage;

  Future<void> _loginUser() async {
    final myBox = Hive.box<User>(Constants.usersBox);
    final User? user = myBox.get(_emailController.text);
    if (user == null || user.password != _passwordController.text) {
      setState(() {
        _isLoginSuccessful = false;
        _errorMessage = "Failed to login.";
      });
      return;
    }

    setState(() {
      _isLoginSuccessful = true;
      _errorMessage = "Login successful. Redirecting...";
    });

    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => ProfileScreen(user: user),
    ));
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
                ],
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true, // Hide password input
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginUser,
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              Text(
                _errorMessage ?? '',
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
