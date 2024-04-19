// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:demo/models/constants.dart';
import 'package:demo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late File _imageFile; // To store the selected image file
  final picker = ImagePicker();
  bool _load = false;
  final myBox = Hive.box<User>(Constants.usersBox);
  late User? user = myBox.get(widget.user.email);

  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        widget.user.imageUrl = pickedFile.path;
        _load = true;
        _saveChanges();
      }
    });
  }

  Future<void> _saveChanges() async {
    await myBox.put(widget.user.email, widget.user);
  }

  void _loadImage() {
    if (widget.user.imageUrl != '') {
      _imageFile = File(widget.user.imageUrl);
      _load = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile picture section
            Stack(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundImage: _load == true
                      ? FileImage(File(widget.user.imageUrl))
                      : null,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt_outlined),
                  onPressed: () => _getImage(ImageSource.camera),
                ),
                IconButton(
                  icon: Icon(Icons.photo_library_outlined),
                  onPressed: () => _getImage(ImageSource.gallery),
                ),
              ],
            ),
            // User information section
            SizedBox(height: 20),
            Text(
              "Name: " + widget.user.name,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Email: " + widget.user.email,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'ID: ' + widget.user.studentId,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Gender: ' +
                  (widget.user.gender == ""
                      ? "Not specified"
                      : widget.user.gender),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Level: " +
                  (widget.user.level.toString() == '0'
                      ? "Not specified"
                      : "${widget.user.level}"), // Replace with actual level
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
