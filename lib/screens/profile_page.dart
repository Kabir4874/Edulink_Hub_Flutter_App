import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final String fullName;
  final String email;
  final String phoneNumber;

  ProfilePage({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  File? _profileImage;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.fullName);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Profile updated!')));

    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue.shade300,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blue.shade200,
                  child: ClipOval(
                    child: _profileImage != null
                        ? Image.file(_profileImage!,
                            width: 150, height: 150, fit: BoxFit.cover)
                        : Icon(Icons.person, size: 80, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              isEditing
                  ? _buildProfileTextField(
                      _fullNameController, 'Full Name', Icons.person)
                  : _buildProfileTextFieldViewOnly(
                      _fullNameController.text, 'Full Name'),
              SizedBox(height: 16),
              isEditing
                  ? _buildProfileTextField(
                      _emailController, 'Email', Icons.email)
                  : _buildProfileTextFieldViewOnly(
                      _emailController.text, 'Email'),
              SizedBox(height: 16),
              isEditing
                  ? _buildProfileTextField(
                      _phoneController, 'Phone Number', Icons.phone)
                  : _buildProfileTextFieldViewOnly(
                      _phoneController.text, 'Phone Number'),
              SizedBox(height: 40),
              isEditing
                  ? ElevatedButton(
                      onPressed: _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade400,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child:
                          Text('Save Profile', style: TextStyle(fontSize: 16)),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditing = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade400,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child:
                          Text('Edit Profile', style: TextStyle(fontSize: 16)),
                    ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTextField(
      TextEditingController controller, String label, IconData icon) {
    return Card(
      elevation: 5,
      shadowColor: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.blue.shade400),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            prefixIcon: Icon(icon, color: Colors.blue.shade400),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTextFieldViewOnly(String value, String label) {
    return Card(
      elevation: 5,
      shadowColor: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Text(
            '$label: $value',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
