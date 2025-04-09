import 'package:flutter/material.dart';
import 'all_professor_list_page.dart'; // Import the professor list page

class AddProfessorPage extends StatefulWidget {
  @override
  _AddProfessorPageState createState() => _AddProfessorPageState();
}

class _AddProfessorPageState extends State<AddProfessorPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _workingAreaController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _profileUrlController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newProfessor = {
        "name": _nameController.text,
        "field": _fieldController.text,
        "workingArea": _workingAreaController.text,
        "description": _descriptionController.text,
        "profileUrl": _profileUrlController.text,
        "imageUrl": _imageUrlController.text,
      };

      // Navigate to the AllProfessorListPage with the new professor data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AllProfessorListPage(professors: [newProfessor]),
        ),
      );
    }
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.red.shade300),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Add Professor'),
        backgroundColor: Colors.red.shade300,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildAdmissionForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildAdmissionForm() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "📌 Enter Professor Details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red.shade700),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField("Professor Name", Icons.person, _nameController),
              _buildTextField("Field", Icons.school, _fieldController),
              _buildTextField("Working Area", Icons.work, _workingAreaController),
              _buildTextField("Description", Icons.description, _descriptionController),
              _buildTextField("Profile URL", Icons.link, _profileUrlController),
              _buildTextField("Image URL", Icons.image, _imageUrlController),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                  label: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
