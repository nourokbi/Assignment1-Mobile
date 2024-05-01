// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, prefer_const_constructors, unused_field

import 'package:demo/models/constants.dart';
import 'package:demo/models/user.dart';
import 'package:demo/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late File _imageFile; // To store the selected image file
  final picker = ImagePicker();
  bool _load = false;
  final myBox = Hive.box<User>(Constants.usersBox);
  late User? user = myBox.get(widget.user.email);

  @override
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 75,
              backgroundImage:
                  _load == true ? FileImage(File(widget.user.imageUrl)) : null,
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProfileInfo('Name', widget.user.name),
                SizedBox(width: 30),
                _buildProfileInfo('ID', widget.user.studentId),
              ],
            ),
            _buildProfileInfo('Email', widget.user.email),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProfileInfo(
                    'Gender',
                    widget.user.gender.isNotEmpty
                        ? widget.user.gender
                        : 'Not specified'),
                SizedBox(width: 70),
                _buildProfileInfo(
                    'Level',
                    widget.user.level != 0
                        ? widget.user.level.toString()
                        : 'Not specified'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$title:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}












//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // ElevatedButton(onPressed: () =>
//             //     {Navigator.pushNamed(context, '/edit-profile')},
//             // child: const Text("Edit Profile")),
//             // Profile picture section
//             CircleAvatar(
//               radius: 75,
//               backgroundImage:
//                   _load == true ? FileImage(File(widget.user.imageUrl)) : null,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.camera_alt_outlined),
//                   onPressed: () => _getImage(ImageSource.camera),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.photo_library_outlined),
//                   onPressed: () => _getImage(ImageSource.gallery),
//                 ),
//               ],
//             ),
//             // User information section
//             SizedBox(height: 20),
//             Text(
//               "Name: " + widget.user.name,
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Email: " + widget.user.email,
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'ID: ' + widget.user.studentId,
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Gender: ' +
//                   (widget.user.gender == ""
//                       ? "Not specified"
//                       : widget.user.gender),
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Level: " +
//                   (widget.user.level.toString() == '0'
//                       ? "Not specified"
//                       : "${widget.user.level}"), // Replace with actual level
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
