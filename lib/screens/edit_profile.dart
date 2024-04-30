import 'dart:io';
import 'package:demo/models/user.dart';
import 'package:demo/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;

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
  late TextEditingController _nameController;
  late TextEditingController _oldPasswordController;
  late TextEditingController _passwordController;
  late File _imageFile;
  final picker = ImagePicker();
  bool _load = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _oldPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    if (widget.user.imageUrl != '') {
      _imageFile = File(widget.user.imageUrl);
      _load = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _load = true;
      });
    }
  }

  bool _validatePassword() {
    if (_oldPasswordController.text != widget.user.password &&
        _passwordController.text.isNotEmpty) {
      return false;
    }
    if (_passwordController.text.isEmpty) {
      return true;
    }
    if (_passwordController.text.length < 8) {
      return false;
    }
    widget.user.password = _passwordController.text;
    return true;
  }

  Future<void> _saveChanges() async {
    final userBox = await Hive.openBox<User>('userBox');
    final newUser = User(
      name: _nameController.text,
      email: widget.user.email,
      password: _validatePassword() ? _passwordController.text : widget.user.password,
      studentId: widget.user.studentId,
      imageUrl: _imageFile.path,
    );
    await userBox.put(widget.user.email, newUser);
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ProfileScreen(user: newUser)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 64,
              backgroundImage:
                  _load ? FileImage(File(widget.user.imageUrl)) : null,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () => _getImage(ImageSource.camera),
                ),
                IconButton(
                  icon: const Icon(Icons.photo_library_outlined),
                  onPressed: () => _getImage(ImageSource.gallery),
                ),
              ],
            ),
            // GestureDetector(
            //   onTap: () => _getImage(ImageSource.gallery),
            //   child: CircleAvatar(
            //     radius: 64,
            //     backgroundImage: FileImage(_imageFile),
            //   ),
            // ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Old Password'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'New Password'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Save'),
            ),
            const SizedBox(height: 10,),
            Text(
              _validatePassword() ? 'Applying Changes' : 'Password is not changing',
              style: TextStyle(color: _validatePassword() ? Colors.green : Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
