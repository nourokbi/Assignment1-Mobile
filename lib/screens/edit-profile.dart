import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late File _imageFile; // To store the selected image file
  final picker = ImagePicker();
  bool _load = false;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        _load = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _load == false
                ? Text('No image selected.')
                : Image.file(_imageFile),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.gallery),
              child: Text('Select Image from Gallery'),
            ),
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.camera),
              child: Text('Capture Image from Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
