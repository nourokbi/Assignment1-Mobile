// ignore_for_file: prefer_const_constructors, prefer_final_fields, library_private_types_in_public_api

import 'package:demo/models/constants.dart';
import 'package:demo/models/user.dart';
import 'package:demo/screens/edit_profile.dart';
import 'package:demo/screens/login.dart';
import 'package:demo/screens/signup.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());

  await Hive.openBox<User>(Constants.usersBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/edit-profile': (context) => EditProfileScreen(
                user: User(
              name: '',
              email: '',
              password: '',
              studentId: '',
            )),
      },
    );
  }
}
