import 'package:flutter/material.dart';
import 'package:edulinkhub/widget/admin_drawer.dart';
import 'admin_admission_list_page.dart';

class AdminAdmissionManagementPage extends StatefulWidget {
  @override
  _AdminAdmissionManagementPageState createState() => _AdminAdmissionManagementPageState();
}

class _AdminAdmissionManagementPageState extends State<AdminAdmissionManagementPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _applyDateController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _applyLinkController = TextEditingController();
  final TextEditingController _admitCardDownloadController = TextEditingController();
  final TextEditingController _examUnitsController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  void _selectDate(BuildContext context, TextEditingController controller) async {
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
        controller.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newAdmission = {
        "name": _nameController.text,
        "location": _locationController.text,
        "applyDate": _applyDateController.text,
        "deadline": _deadlineController.text,
        "applyLink": _applyLinkController.text,
        "admitCardDownload": _admitCardDownloadController.text,
        "examUnits": _examUnitsController.text.split(","),
        "imageUrl": _imageUrlController.text,
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminAdmissionListPage(admissions: [newAdmission]),
        ),
      );
    }
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
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

  Widget _buildDateField(String label, TextEditingController controller) {
    return GestureDetector(
      onTap: () => _selectDate(context, controller),
      child: AbsorbPointer(
        child: _buildTextField(label, Icons.calendar_today, controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Manage University Admission', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red.shade700),
                ),
              ),
              SizedBox(height: 16),
              _buildTextField("University Name", Icons.school, _nameController),
              _buildTextField("Location", Icons.location_city, _locationController),
              _buildDateField("Apply Date", _applyDateController),
              _buildDateField("Deadline", _deadlineController),
              _buildTextField("Apply Link", Icons.link, _applyLinkController),
              _buildDateField("Admit Card Download Date", _admitCardDownloadController),
              _buildTextField("Exam Units (Comma Separated)", Icons.list, _examUnitsController),
              _buildTextField("Image URL", Icons.image, _imageUrlController),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: Icon(Icons.check_circle, color: Colors.white),
                  label: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.black,
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
