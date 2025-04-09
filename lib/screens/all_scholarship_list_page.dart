import 'package:flutter/material.dart';
import 'package:edulinkhub/widget/admin_drawer.dart';

class AllScholarshipListPage extends StatefulWidget {
  final List<Map<String, dynamic>> scholarships;

  const AllScholarshipListPage({required this.scholarships, super.key});

  @override
  State<AllScholarshipListPage> createState() => _AllScholarshipListPageState();
}

class _AllScholarshipListPageState extends State<AllScholarshipListPage> {
  late List<Map<String, dynamic>> _scholarships;

  @override
  void initState() {
    super.initState();
    _scholarships = List<Map<String, dynamic>>.from(widget.scholarships);
  }

  void _editScholarship(int index) {
    final scholarship = _scholarships[index];

    final TextEditingController universityNameController = TextEditingController(text: scholarship['universityName'] ?? '');
    final TextEditingController scholarshipNameController = TextEditingController(text: scholarship['scholarshipName'] ?? '');
    final TextEditingController departmentController = TextEditingController(text: scholarship['department'] ?? '');
    final TextEditingController applyDateController = TextEditingController(text: scholarship['applyDate'] ?? '');
    final TextEditingController deadlineController = TextEditingController(text: scholarship['deadline'] ?? '');
    final TextEditingController descriptionController = TextEditingController(text: scholarship['description'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Scholarship Info"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: universityNameController, decoration: const InputDecoration(labelText: 'University Name')),
              TextField(controller: scholarshipNameController, decoration: const InputDecoration(labelText: 'Scholarship Name')),
              TextField(controller: departmentController, decoration: const InputDecoration(labelText: 'Department')),
              TextField(controller: applyDateController, decoration: const InputDecoration(labelText: 'Apply Date (MM/DD/YYYY)')),
              TextField(controller: deadlineController, decoration: const InputDecoration(labelText: 'Deadline (MM/DD/YYYY)')),
              TextField(controller: descriptionController, decoration: const InputDecoration(labelText: 'Description')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300),
            onPressed: () {
              setState(() {
                _scholarships[index] = {
                  'universityName': universityNameController.text,
                  'scholarshipName': scholarshipNameController.text,
                  'department': departmentController.text,
                  'applyDate': applyDateController.text,
                  'deadline': deadlineController.text,
                  'description': descriptionController.text,
                };
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _deleteScholarship(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Are you sure you want to delete ${_scholarships[index]['scholarshipName']}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _scholarships.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Scholarship List'),
        backgroundColor: Colors.red.shade300, // Changed to red
      ),
      drawer: AdminDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _scholarships.length,
        itemBuilder: (context, index) {
          final scholarship = _scholarships[index];
          final description = scholarship['description'] ?? 'No description available';

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              title: Text(
                scholarship['scholarshipName'] ?? 'Unnamed Scholarship',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "University: ${scholarship['universityName'] ?? 'N/A'}\n"
                    "Department: ${scholarship['department'] ?? 'N/A'}\n"
                    "Apply Date: ${scholarship['applyDate'] ?? 'N/A'}\n"
                    "Deadline: ${scholarship['deadline'] ?? 'N/A'}\n"
                    "Description: $description",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.red), // Changed to red
                    onPressed: () => _editScholarship(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red), // Changed to red
                    onPressed: () => _deleteScholarship(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
