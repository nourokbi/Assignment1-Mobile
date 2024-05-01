import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String studentId,
    String? gender,
    String? level,
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create a new User object
      UserData user = UserData(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        studentId: studentId,
        password: password,
        level: level,
        gender: gender,
      );

      // Add user data to Firestore
      // await _usersCollection.doc(userCredential.user!.uid).set(user.toMap());
      _usersCollection
          .add(user.toMap())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      print('Error signing up: $e');
      throw e; // Rethrow the exception to handle it in the UI
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in with email and password
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Sign-in successful, no further action needed in this method
    } catch (e) {
      print('Error signing in: $e');
      throw e; // Rethrow the exception to handle it in the UI
    }
  }
}
