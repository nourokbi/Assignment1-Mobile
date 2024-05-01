// ignore_for_file: library_private_types_in_public_api
import 'package:demo/models/constants.dart';
import 'package:demo/models/service_auth.dart';
import 'package:demo/models/user.dart';
import 'package:demo/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _gender = '';
  int _level = 0;

  String? _nameError;
  String? _studentIdError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _signupError;

  bool _isSignupSuccessful = false;

  String validateEmail(String email) {
    final emailRegex = RegExp(r"^\d{8}@stud\.fci-cu\.edu\.eg$");
    if (email.isEmpty) {
      return 'Email is required';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Invalid FCI email structure';
    }
    return "";
  }

  String validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return '';
  }

  Future<void> _signupUser() async {
    final myBox = Hive.box<User>(Constants.usersBox);
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameError = 'Name is required';
      });
    } else {
      setState(() {
        _nameError = null;
      });
    }

    if (_studentIdController.text.isEmpty) {
      setState(() {
        _studentIdError = 'Student ID is required';
      });
    } else {
      setState(() {
        _studentIdError = null;
      });
    }

    if (validateEmail(_emailController.text) != "") {
      setState(() {
        _emailError = validateEmail(_emailController.text);
      });
    } else {
      setState(() {
        _emailError = null;
      });
    }

    if (validatePassword(_passwordController.text) != "") {
      setState(() {
        _passwordError = validatePassword(_passwordController.text);
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
      });
    } else {
      setState(() {
        _confirmPasswordError = null;
      });
    }
    if (_nameError == null &&
        _studentIdError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null) {
      setState(() {
        _isSignupSuccessful = true;
        _signupError = "Signup successful. Redirecting...";
      });

      User user = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        studentId: _studentIdController.text,
        imageUrl: '',
        gender: _gender,
        level: _level,
      );
      myBox.put(_emailController.text, user);
      AuthService().signUpWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        studentId: _studentIdController.text,
        // imageUrl: "",
        gender: _gender,
        level: _level.toString(),
      );
      await Future.delayed(const Duration(seconds: 1));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ));
    } else {
      setState(() {
        _isSignupSuccessful = false;
        _signupError = "Failed to signup.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
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
                        onPressed: () => {Navigator.pushNamed(context, '/')},
                        child: const Text('Login')),
                  ],
                ),
                TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Name*',
                    prefixIcon: const Icon(Icons.person),
                    errorText: _nameError,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _studentIdController,
                  decoration: InputDecoration(
                    labelText: 'Student ID*',
                    prefixIcon: const Icon(Icons.school),
                    errorText: _studentIdError,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email (FCI structure)*',
                    prefixIcon: const Icon(Icons.email),
                    errorText: _emailError,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password (at least 8 characters)*',
                    prefixIcon: const Icon(Icons.lock),
                    errorText: _passwordError,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock),
                    errorText: _confirmPasswordError,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(Icons.question_mark),
                    const SizedBox(width: 10),
                    const Text('Gender:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Radio(
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (value) =>
                          setState(() => _gender = value.toString()),
                    ),
                    const Text('Male'),
                    Radio(
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (value) => setState(() => _gender = value!),
                    ),
                    const Text('Female'),
                  ],
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<int>(
                  value: _level,
                  hint: const Text('Select Level (optional)'),
                  items: const [
                    DropdownMenuItem(
                        value: 0,
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.auto_stories),
                            SizedBox(width: 10),
                            Text('Select Level')
                          ],
                        )),
                    DropdownMenuItem(value: 1, child: Text('Level 1')),
                    DropdownMenuItem(value: 2, child: Text('Level 2')),
                    DropdownMenuItem(value: 3, child: Text('Level 3')),
                    DropdownMenuItem(value: 4, child: Text('Level 4')),
                  ],
                  onChanged: (value) => setState(() => _level = value!),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _signupUser,
                  child: const Text('Signup'),
                ),
                const SizedBox(height: 15),
                Text(
                  _signupError ?? "",
                  style: TextStyle(
                      color: _isSignupSuccessful ? Colors.green : Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
