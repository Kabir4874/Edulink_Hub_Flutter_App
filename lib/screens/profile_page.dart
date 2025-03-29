import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';  // Add this import to use ImagePicker
import 'dart:io';

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
  File? _profileImage;  // To store the selected profile image
  bool isEditing = false; // Flag to determine if we are in edit mode

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the passed user data
    _fullNameController = TextEditingController(text: widget.fullName);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Function to pick an image using the ImagePicker
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);  // Update the profile image
      });
    }
  }

  // Function to save the profile data
  void _saveProfile() {
    // Here, you can implement saving the data to a database or backend
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated!')));

    // Toggle the edit mode after saving
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
      body: SingleChildScrollView(  // Wrap body in a ScrollView to handle smaller screens
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              // Profile Image with border and shadow
              GestureDetector(
                onTap: _pickImage,  // Pick an image when tapped
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blue.shade200,
                  child: ClipOval(
                    child: _profileImage != null
                        ? Image.file(_profileImage!, width: 150, height: 150, fit: BoxFit.cover)
                        : Icon(Icons.person, size: 80, color: Colors.white), // Default Icon
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Full Name Field
              isEditing
                  ? _buildProfileTextField(_fullNameController, 'Full Name', Icons.person)
                  : _buildProfileTextFieldViewOnly(_fullNameController.text, 'Full Name'),
              SizedBox(height: 16),
              // Email Field
              isEditing
                  ? _buildProfileTextField(_emailController, 'Email', Icons.email)
                  : _buildProfileTextFieldViewOnly(_emailController.text, 'Email'),
              SizedBox(height: 16),
              // Phone Number Field
              isEditing
                  ? _buildProfileTextField(_phoneController, 'Phone Number', Icons.phone)
                  : _buildProfileTextFieldViewOnly(_phoneController.text, 'Phone Number'),
              SizedBox(height: 40),
              // Save or Edit Button
              isEditing
                  ? ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400, // Use backgroundColor instead of primary
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  elevation: 5,
                ),
                child: Text('Save Profile', style: TextStyle(fontSize: 16)),
              )
                  : ElevatedButton(
                onPressed: () {
                  setState(() {
                    isEditing = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400, // Use backgroundColor instead of primary
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  elevation: 5,
                ),
                child: Text('Edit Profile', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields for user profile information
  Widget _buildProfileTextField(TextEditingController controller, String label, IconData icon) {
    return Card(
      elevation: 5,
      shadowColor: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners for the card
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

  // Helper method to build text fields that are only viewable (non-editable)
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
