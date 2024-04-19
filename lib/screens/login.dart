// ignore_for_file: library_private_types_in_public_api, unused_local_variable, unnecessary_null_comparison

import 'package:demo/models/constants.dart';
import 'package:demo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:demo/screens/edit_profile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoginSuccessful = false;

  Future<void> _loginUser() async {
    // await Future.delayed(const Duration(seconds: 1));
    final myBox = Hive.box<User>(Constants.usersBox);
    final User? user = myBox.get(_emailController.text);
    if (user == null) {
      setState(() {
        _isLoginSuccessful = false;
      });
      return;
    }

    if (user.name == "") {
      setState(() {
        _isLoginSuccessful = false;
      });
      return;
    }

    if (user.password == _passwordController.text) {
      setState(() {
        _isLoginSuccessful = true;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => EditProfileScreen(user: user),
      ));
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
                  const SizedBox(width: 20),
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
