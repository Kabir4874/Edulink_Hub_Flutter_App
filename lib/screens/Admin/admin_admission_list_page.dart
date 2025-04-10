import 'dart:convert';

import 'package:edulinkhub/widget/admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AdminAdmissionListPage extends StatefulWidget {
  const AdminAdmissionListPage({super.key});

  @override
  State<AdminAdmissionListPage> createState() => _AdminAdmissionListPageState();
}

class _AdminAdmissionListPageState extends State<AdminAdmissionListPage> {
  late List<Map<String, dynamic>> _admissions;
  bool _isLoading = false;
  final List<String> _programTypes = ['undergraduate', 'postgraduate', 'Ph.D.'];

  @override
  void initState() {
    super.initState();
    _admissions = [];
    _fetchUniversities();
  }

  Future<void> _fetchUniversities() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://edulink-hub-backend.onrender.com/university/get-all'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['universities'] != null && data['universities'] is List) {
          setState(() {
            _admissions = List<Map<String, dynamic>>.from(data['universities']);
          });
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch universities')),
        );
      }
    } catch (error) {
      print('Error fetching universities: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching universities')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  String formatDate(String dateString) {
    try {
      if (dateString.contains('T')) {
        // Handle ISO format
        DateTime date = DateTime.parse(dateString);
        return DateFormat('dd MMM yyyy').format(date);
      } else {
        // Handle d/M/yyyy format
        final DateFormat format = DateFormat('d/M/yyyy');
        DateTime date = format.parse(dateString);
        return DateFormat('dd MMM yyyy').format(date);
      }
    } catch (e) {
      return dateString;
    }
  }

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
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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

  void _editAdmission(int index) {
    final admission = _admissions[index];

    final TextEditingController nameController =
        TextEditingController(text: admission['name']);
    final TextEditingController locationController =
        TextEditingController(text: admission['location']);
    String? programType = admission['programType'];
    final TextEditingController disciplineController =
        TextEditingController(text: admission['discipline']);
    final TextEditingController applyDateController = TextEditingController(
        text: formatDate(admission['applicationDate']).replaceAll(' ', '/'));
    final TextEditingController deadlineController = TextEditingController(
        text:
            formatDate(admission['applicationDeadline']).replaceAll(' ', '/'));
    final TextEditingController applyLinkController =
        TextEditingController(text: admission['admissionLink']);
    final TextEditingController admitCardController = TextEditingController(
        text: formatDate(admission['admitCardDownloadDate'])
            .replaceAll(' ', '/'));
    final TextEditingController imageUrlController =
        TextEditingController(text: admission['imageUrl']);

    List<Map<String, dynamic>> examUnits = [];
    if (admission['examUnits'] is List) {
      examUnits =
          List<Map<String, dynamic>>.from(admission['examUnits'].map((unit) {
        return {
          'unit': TextEditingController(text: unit['unit']),
          'date': TextEditingController(
              text: formatDate(unit['date']).replaceAll(' ', '/')),
        };
      }).toList());
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          void addExamUnit() {
            setState(() {
              examUnits.add({
                'unit': TextEditingController(),
                'date': TextEditingController(),
              });
            });
          }

          void removeExamUnit(int index) {
            setState(() {
              examUnits.removeAt(index);
            });
          }

          return AlertDialog(
            title: const Text("Edit Admission Info"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(labelText: 'University Name'),
                  ),
                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                  ),
                  DropdownButtonFormField<String>(
                    value: programType,
                    items: _programTypes.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        programType = value;
                      });
                    },
                    decoration:
                        const InputDecoration(labelText: 'Program Type'),
                  ),
                  TextField(
                    controller: disciplineController,
                    decoration: const InputDecoration(labelText: 'Discipline'),
                    maxLines: 3,
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, applyDateController),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: applyDateController,
                        decoration: const InputDecoration(
                            labelText: 'Application Date'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, deadlineController),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: deadlineController,
                        decoration: const InputDecoration(
                            labelText: 'Application Deadline'),
                      ),
                    ),
                  ),
                  TextField(
                    controller: applyLinkController,
                    decoration:
                        const InputDecoration(labelText: 'Application Link'),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, admitCardController),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: admitCardController,
                        decoration: const InputDecoration(
                            labelText: 'Admit Card Download Date'),
                      ),
                    ),
                  ),
                  TextField(
                    controller: imageUrlController,
                    decoration: const InputDecoration(labelText: 'Image URL'),
                  ),
                  const SizedBox(height: 16),
                  const Text('Exam Units:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ...examUnits
                      .map((unit) => Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: unit['unit'],
                                  decoration:
                                      const InputDecoration(labelText: 'Unit'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      _selectDate(context, unit['date']),
                                  child: AbsorbPointer(
                                    child: TextField(
                                      controller: unit['date'],
                                      decoration: const InputDecoration(
                                          labelText: 'Date'),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    removeExamUnit(examUnits.indexOf(unit)),
                              ),
                            ],
                          ))
                      .toList(),
                  ElevatedButton(
                    onPressed: addExamUnit,
                    child: const Text('Add Exam Unit'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade300),
                onPressed: () async {
                  final updatedAdmission = {
                    "name": nameController.text,
                    "location": locationController.text,
                    "programType": programType,
                    "discipline": disciplineController.text,
                    "applicationDate":
                        _convertToISODate(applyDateController.text),
                    "applicationDeadline":
                        _convertToISODate(deadlineController.text),
                    "admissionLink": applyLinkController.text,
                    "admitCardDownloadDate":
                        _convertToISODate(admitCardController.text),
                    "examUnits": examUnits
                        .map((unit) => {
                              "unit": unit['unit'].text,
                              "date": _convertToISODate(unit['date'].text),
                            })
                        .toList(),
                    "imageUrl": imageUrlController.text,
                  };

                  final response = await http.put(
                    Uri.parse(
                        'https://edulink-hub-backend.onrender.com/university/update/${admission['_id']}'),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode(updatedAdmission),
                  );

                  if (response.statusCode == 200) {
                    setState(() {
                      _admissions[index] = updatedAdmission;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('University updated successfully!')),
                    );
                    _fetchUniversities();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Failed to update university')),
                    );
                  }
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      ),
    );
  }

  String _convertToISODate(String date) {
    try {
      final parts = date.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      final parsedDate = DateTime(year, month, day);
      return parsedDate.toIso8601String();
    } catch (e) {
      return date; // Return the original date if parsing fails
    }
  }

  void _deleteAdmission(int index) async {
    final admission = _admissions[index];
    final response = await http.delete(
      Uri.parse(
          'https://edulink-hub-backend.onrender.com/university/delete/${admission['_id']}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _admissions.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('University deleted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete university')),
      );
    }
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _admissions.length,
              itemBuilder: (context, index) {
                final admission = _admissions[index];
                final imageUrl = admission['imageUrl'] ?? '';
                final examUnits = (admission['examUnits'] is List)
                    ? (admission['examUnits'] as List)
                        .map((unit) =>
                            '${unit['unit']} (${formatDate(unit['date'])})')
                        .join(", ")
                    : (admission['examUnits']?.toString() ?? '');

                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (imageUrl.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                ),
                              )
                            else
                              const Icon(Icons.image, size: 50),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    admission['name'] ?? 'Unnamed University',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    admission['location'] ?? 'N/A',
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () => _editAdmission(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => _deleteAdmission(index),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Program: ${admission['programType'] ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Discipline: ${admission['discipline'] ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Apply Date: ${formatDate(admission['applicationDate'])}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Deadline: ${formatDate(admission['applicationDeadline'])}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        if (examUnits.isNotEmpty)
                          Text(
                            'Exam Units: $examUnits',
                            style: const TextStyle(fontSize: 14),
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
