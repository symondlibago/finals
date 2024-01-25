import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateProfile(),
    );
  }
}

class CreateProfile extends StatefulWidget {
  File? _selectedImage;

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _about = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      child: Icon(Icons.person, size: 60.0),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: InkWell(
                        onTap: () {
                          _showImagePickerOptions();
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _name,
                  validator: (value) {
                    if (value!.isEmpty) return "Name can't be empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Enter your name",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _profession,
                  validator: (value) {
                    if (value!.isEmpty) return "Profession can't be empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Profession",
                    hintText: "Enter your profession",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _dob,
                  validator: (value) {
                    if (value!.isEmpty) return "DOB can't be empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Date Of Birth",
                    hintText: "Enter your date of birth (dd/mm/yyyy)",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _title,
                  validator: (value) {
                    if (value!.isEmpty) return "Title can't be empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Title",
                    hintText: "Enter your title",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _about,
                  validator: (value) {
                    if (value!.isEmpty) return "About can't be empty";
                    return null;
                  },
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "About",
                    hintText: "Write about yourself",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {}
                  },
                  child: Text("Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Take a picture'),
              onTap: () {
                _pickImageFromCam();
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Choose from gallery'),
              onTap: () {
                _pickImageFromGallery();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      widget._selectedImage = File(returnedImage!.path);
    });
  }

  Future<void> _pickImageFromCam() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      widget._selectedImage = File(returnedImage!.path);
    });
  }
}
