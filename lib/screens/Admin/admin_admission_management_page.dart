import 'dart:convert';

import 'package:edulinkhub/screens/Admin/admin_admission_list_page.dart';
import 'package:edulinkhub/widget/admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AdminAdmissionManagementPage extends StatefulWidget {
  @override
  _AdminAdmissionManagementPageState createState() =>
      _AdminAdmissionManagementPageState();
}

class _AdminAdmissionManagementPageState
    extends State<AdminAdmissionManagementPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _programTypeController = TextEditingController();
  final TextEditingController _disciplineController = TextEditingController();
  final TextEditingController _applyDateController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _applyLinkController = TextEditingController();
  final TextEditingController _admitCardDownloadController =
      TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  List<Map<String, dynamic>> _examUnits = [];
  bool _isLoading = false; // Flag for loading state
  String? _programType; // Store the selected program type

  // List of program types for the dropdown menu
  final List<String> _programTypes = ['undergraduate', 'postgraduate', 'Ph.D.'];

  void _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.red.shade300,
              secondary: Colors.red.shade300,
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        controller.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  void _addExamUnit() {
    setState(() {
      _examUnits.add({
        'unit': TextEditingController(),
        'date': TextEditingController(),
      });
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Start loading
      });

      // Convert the date strings to DateTime objects
      DateFormat dateFormat = DateFormat("d/M/yyyy");

      DateTime applicationDate = dateFormat.parse(_applyDateController.text);
      DateTime applicationDeadline = dateFormat.parse(_deadlineController.text);

      // For examUnits, we also need to convert their dates
      List<Map<String, dynamic>> examUnits = _examUnits.map((unit) {
        DateTime examDate = dateFormat.parse(unit['date']!.text);
        return {
          "unit": unit['unit']!.text,
          "date": examDate
              .toIso8601String(), // Convert DateTime to ISO format string
        };
      }).toList();

      // Convert admitCardDownloadDate to a DateTime object
      DateTime admitCardDownloadDate =
          dateFormat.parse(_admitCardDownloadController.text);

      // Ensure programType is valid and trim any extra spaces
      String programType = _programType ?? ''; // Ensure it's selected

      final newAdmission = {
        "name": _nameController.text.trim(),
        "location": _locationController.text,
        "programType": programType, // Make sure it's a valid value
        "discipline": _disciplineController.text,
        "applicationDate":
            applicationDate.toIso8601String(), // Convert to ISO string
        "applicationDeadline":
            applicationDeadline.toIso8601String(), // Convert to ISO string
        "admissionLink": _applyLinkController.text,
        "admitCardDownloadDate":
            admitCardDownloadDate.toIso8601String(), // Convert to ISO string
        "examUnits": examUnits,
        "imageUrl": _imageUrlController.text,
      };

      // Send data to backend
      final response = await http.post(
        Uri.parse('https://edulink-hub-backend.onrender.com/university/create'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(newAdmission),
      );

      setState(() {
        _isLoading = false; // Stop loading
      });

      if (response.statusCode == 201) {
        // Show success message via Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('University added successfully!')),
        );

        // Navigate to the admission list page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminAdmissionListPage(),
          ),
        );
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add university admission')),
        );
      }
    }
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool isMultiline = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: isMultiline ? 5 : 1,
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

  Widget _buildDateField(String label, TextEditingController controller) {
    return GestureDetector(
      onTap: () => _selectDate(context, controller),
      child: AbsorbPointer(
        child: _buildTextField(label, Icons.calendar_today, controller),
      ),
    );
  }

  Widget _buildExamUnitFields(int index) {
    return Row(
      children: [
        Expanded(
          child:
              _buildTextField("Unit", Icons.book, _examUnits[index]['unit']!),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _buildDateField("Date", _examUnits[index]['date']!),
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            setState(() {
              _examUnits.removeAt(index);
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Manage University Admission',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red.shade300,
      ),
      drawer: AdminDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
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
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "📌 Enter Admission Details",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700),
                ),
              ),
              SizedBox(height: 16),
              _buildTextField("University Name", Icons.school, _nameController),
              _buildTextField(
                  "Location", Icons.location_city, _locationController),
              // Program Type Dropdown
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  value: _programType,
                  hint: Text("Select Program Type"),
                  items: _programTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _programType = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Program Type",
                    prefixIcon:
                        Icon(Icons.menu_book, color: Colors.red.shade300),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a program type';
                    }
                    return null;
                  },
                ),
              ),
              _buildTextField(
                  "Discipline", Icons.subject, _disciplineController,
                  isMultiline: true),
              _buildDateField("Application Date", _applyDateController),
              _buildDateField("Application Deadline", _deadlineController),
              _buildTextField(
                  "Application Link", Icons.link, _applyLinkController),
              _buildDateField(
                  "Admit Card Download Date", _admitCardDownloadController),
              _buildTextField("Image URL", Icons.image, _imageUrlController),
              SizedBox(height: 20),

              // Exam Units Section
              Text("Exam Units",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700)),
              SizedBox(height: 10),
              ..._examUnits
                  .map((unit) => _buildExamUnitFields(_examUnits.indexOf(unit)))
                  .toList(),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _addExamUnit,
                icon: Icon(Icons.add, color: Colors.white),
                label: Text("Add Exam Unit"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),

              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Icon(Icons.check_circle, color: Colors.white),
                  label: Text(_isLoading ? "Submitting..." : "Submit"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
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
