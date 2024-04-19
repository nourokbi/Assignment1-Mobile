import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _studentIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _gender = '';
  int _level = 0;

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
    // Replace this with your actual signup logic (e.g., API call)
    // Simulate successful signup for this example
    await Future.delayed(Duration(seconds: 1));
    if (_nameController.text.isNotEmpty &&
        validateEmail(_emailController.text) == "" &&
        _studentIdController.text.isNotEmpty &&
        validatePassword(_passwordController.text) == "" &&
        _passwordController.text == _confirmPasswordController.text) {
      setState(() {
        _isSignupSuccessful = true;
      });
    } else {
      setState(() {
        _isSignupSuccessful = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
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
                        child: Text('Login')),
                    /*ElevatedButton(
                        onPressed: () =>
                            {Navigator.pushNamed(context, '/edit-profile')},
                        child: Text('Edit Profile')),*/
                  ],
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name*',
                    errorText: _nameController.text.isEmpty
                        ? 'Name is required'
                        : null,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Gender:'),
                    Radio(
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (value) =>
                          setState(() => _gender = value.toString()),
                    ),
                    Text('Male'),
                    Radio(
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (value) => setState(() => _gender = value!),
                    ),
                    Text('Female'),
                  ],
                ),
                SizedBox(height: 5),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email (FCI structure)*',
                    errorText: validateEmail(_emailController.text) == ""
                        ? null
                        : validateEmail(_emailController.text),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  controller: _studentIdController,
                  decoration: InputDecoration(
                    labelText: 'Student ID*',
                    errorText: _studentIdController.text.isEmpty
                        ? 'Student ID is required'
                        : null,
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  value: _level,
                  hint: Text('Select Level (optional)'),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('Select Level')),
                    DropdownMenuItem(value: 1, child: Text('Level 1')),
                    DropdownMenuItem(value: 2, child: Text('Level 2')),
                    DropdownMenuItem(value: 3, child: Text('Level 3')),
                    DropdownMenuItem(value: 4, child: Text('Level 4')),
                  ],
                  onChanged: (value) => setState(() => _level = value!),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password (at least 8 characters)*',
                    errorText: validatePassword(_passwordController.text) == ''
                        ? null
                        : validatePassword(_passwordController.text),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    errorText: _passwordController.text !=
                            _confirmPasswordController.text
                        ? 'Passwords do not match'
                        : null,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _signupUser,
                  child: Text('Signup'),
                ),
                SizedBox(height: 15),
                _isSignupSuccessful
                    ? Text(
                        'Signup Success',
                        style: TextStyle(color: Colors.green),
                      )
                    : Text(
                        'Signup Failure',
                        style: TextStyle(color: Colors.red),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
