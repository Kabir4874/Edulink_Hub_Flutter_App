import 'package:flutter/material.dart';
import 'all_scholarship_list_page.dart'; // Import the scholarship list page

class AddScholarshipPage extends StatefulWidget {
  const AddScholarshipPage({super.key});

  @override
  State<AddScholarshipPage> createState() => _AddScholarshipPageState();
}

class _AddScholarshipPageState extends State<AddScholarshipPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _universityNameController = TextEditingController();
  final TextEditingController _scholarshipNameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _applyDateController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newScholarship = {
        "universityName": _universityNameController.text,
        "scholarshipName": _scholarshipNameController.text,
        "department": _departmentController.text,
        "applyDate": _applyDateController.text,
        "deadline": _deadlineController.text,
        "description": _descriptionController.text,
      };

      // Navigate to the AllScholarshipListPage with the new scholarship data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AllScholarshipListPage(scholarships: [newScholarship]),
        ),
      );
    }
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, {bool isDateField = false}) {
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
        onTap: isDateField
            ? () => _selectDate(context, controller) // Open date picker if the field is a date field
            : null,
        readOnly: isDateField, // Make the text field readonly so that user cannot manually enter date
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Add Scholarship'),
        backgroundColor: Colors.red.shade300,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildScholarshipForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildScholarshipForm() {
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
                  "📌 Enter Scholarship Details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red.shade300),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField("University Name", Icons.school, _universityNameController),
              _buildTextField("Scholarship Name", Icons.card_giftcard, _scholarshipNameController),
              _buildTextField("Department", Icons.business, _departmentController),
              _buildTextField("Apply Date (MM/DD/YYYY)", Icons.date_range, _applyDateController, isDateField: true),
              _buildTextField("Deadline (MM/DD/YYYY)", Icons.calendar_today, _deadlineController, isDateField: true),
              _buildTextField("Description", Icons.description, _descriptionController),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                  label: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.red.shade400,
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
