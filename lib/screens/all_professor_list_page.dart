import 'package:flutter/material.dart';
import 'package:edulinkhub/widget/admin_drawer.dart';

class AllProfessorListPage extends StatefulWidget {
  final List<Map<String, dynamic>> professors;

  const AllProfessorListPage({required this.professors, super.key});

  @override
  State<AllProfessorListPage> createState() => _AllProfessorListPageState();
}

class _AllProfessorListPageState extends State<AllProfessorListPage> {
  late List<Map<String, dynamic>> _professors;

  @override
  void initState() {
    super.initState();
    _professors = List<Map<String, dynamic>>.from(widget.professors);
  }

  void _editProfessor(int index) {
    final professor = _professors[index];

    final TextEditingController nameController = TextEditingController(text: professor['name'] ?? '');
    final TextEditingController fieldController = TextEditingController(text: professor['field'] ?? '');
    final TextEditingController workingAreaController = TextEditingController(text: professor['workingArea'] ?? '');
    final TextEditingController descriptionController = TextEditingController(text: professor['description'] ?? '');
    final TextEditingController profileUrlController = TextEditingController(text: professor['profileUrl'] ?? '');
    final TextEditingController imageUrlController = TextEditingController(text: professor['imageUrl'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Professor Info"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Professor Name')),
              TextField(controller: fieldController, decoration: const InputDecoration(labelText: 'Field')),
              TextField(controller: workingAreaController, decoration: const InputDecoration(labelText: 'Working Area')),
              TextField(controller: descriptionController, decoration: const InputDecoration(labelText: 'Description')),
              TextField(controller: profileUrlController, decoration: const InputDecoration(labelText: 'Profile URL')),
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
                _professors[index] = {
                  "name": nameController.text,
                  "field": fieldController.text,
                  "workingArea": workingAreaController.text,
                  "description": descriptionController.text,
                  "profileUrl": profileUrlController.text,
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

  void _deleteProfessor(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Are you sure you want to delete ${_professors[index]['name']}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _professors.removeAt(index);
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
        title: const Text('Professor List'),
        backgroundColor: Colors.red.shade300,
      ),
      drawer: AdminDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _professors.length,
        itemBuilder: (context, index) {
          final professor = _professors[index];
          final imageUrl = professor['imageUrl'] ?? '';
          final description = professor['description'] ?? 'No description';

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
                professor['name'] ?? 'Unnamed Professor',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Field: ${professor['field'] ?? 'N/A'}\n"
                    "Working Area: ${professor['workingArea'] ?? 'N/A'}\n"
                    "Description: $description\n"
                    "Profile URL: ${professor['profileUrl'] ?? 'N/A'}",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.red),
                    onPressed: () => _editProfessor(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteProfessor(index),
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
