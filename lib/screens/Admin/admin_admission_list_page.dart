import 'package:flutter/material.dart';
import 'package:edulinkhub/widget/admin_drawer.dart';

class AdminAdmissionListPage extends StatefulWidget {
  final List<Map<String, dynamic>> admissions;

  const AdminAdmissionListPage({required this.admissions, super.key});

  @override
  State<AdminAdmissionListPage> createState() => _AdminAdmissionListPageState();
}

class _AdminAdmissionListPageState extends State<AdminAdmissionListPage> {
  late List<Map<String, dynamic>> _admissions;

  @override
  void initState() {
    super.initState();
    _admissions = List<Map<String, dynamic>>.from(widget.admissions);
  }

  void _editAdmission(int index) {
    final admission = _admissions[index];

    final TextEditingController nameController = TextEditingController(text: admission['name'] ?? '');
    final TextEditingController locationController = TextEditingController(text: admission['location'] ?? '');
    final TextEditingController applyDateController = TextEditingController(text: admission['applyDate'] ?? '');
    final TextEditingController deadlineController = TextEditingController(text: admission['deadline'] ?? '');
    final TextEditingController applyLinkController = TextEditingController(text: admission['applyLink'] ?? '');
    final TextEditingController admitCardController = TextEditingController(text: admission['admitCardDownload'] ?? '');
    final TextEditingController examUnitsController = TextEditingController(
      text: (admission['examUnits'] is List)
          ? (admission['examUnits'] as List).join(", ")
          : (admission['examUnits']?.toString() ?? ''),
    );
    final TextEditingController imageUrlController = TextEditingController(text: admission['imageUrl'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Admission Info"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'University Name')),
              TextField(controller: locationController, decoration: const InputDecoration(labelText: 'Location')),
              TextField(controller: applyDateController, decoration: const InputDecoration(labelText: 'Apply Date')),
              TextField(controller: deadlineController, decoration: const InputDecoration(labelText: 'Deadline')),
              TextField(controller: applyLinkController, decoration: const InputDecoration(labelText: 'Apply Link')),
              TextField(controller: admitCardController, decoration: const InputDecoration(labelText: 'Admit Card Download Date')),
              TextField(controller: examUnitsController, decoration: const InputDecoration(labelText: 'Exam Units (comma separated)')),
              TextField(controller: imageUrlController, decoration: const InputDecoration(labelText: 'Image URL')),
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
                _admissions[index] = {
                  "name": nameController.text,
                  "location": locationController.text,
                  "applyDate": applyDateController.text,
                  "deadline": deadlineController.text,
                  "applyLink": applyLinkController.text,
                  "admitCardDownload": admitCardController.text,
                  "examUnits": examUnitsController.text
                      .split(",")
                      .map((e) => e.trim())
                      .where((e) => e.isNotEmpty)
                      .toList(),
                  "imageUrl": imageUrlController.text,
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

  void _deleteAdmission(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Are you sure you want to delete ${_admissions[index]['name']}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _admissions.removeAt(index);
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
        title: const Text('Admission List'),
        backgroundColor: Colors.red.shade300,
      ),
      drawer: AdminDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _admissions.length,
        itemBuilder: (context, index) {
          final admission = _admissions[index];
          final imageUrl = admission['imageUrl'] ?? '';
          final examUnits = (admission['examUnits'] is List)
              ? (admission['examUnits'] as List).join(", ")
              : (admission['examUnits']?.toString() ?? '');

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              leading: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
              )
                  : const Icon(Icons.image),
              title: Text(
                admission['name'] ?? 'Unnamed University',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Location: ${admission['location'] ?? 'N/A'}\n"
                    "Apply Date: ${admission['applyDate'] ?? 'N/A'}\n"
                    "Deadline: ${admission['deadline'] ?? 'N/A'}\n"
                    "Admit Card: ${admission['admitCardDownload'] ?? 'N/A'}\n"
                    "Units: $examUnits\n"
                    "Link: ${admission['applyLink'] ?? 'N/A'}",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editAdmission(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteAdmission(index),
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
