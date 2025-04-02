import 'package:flutter/material.dart';

class ScholarshipDetailPage extends StatelessWidget {
  final String universityName;
  final String scholarshipName;
  final String department;
  final String applyDate;
  final String deadline;
  final String description;

  ScholarshipDetailPage({
    required this.universityName,
    required this.scholarshipName,
    required this.department,
    required this.applyDate,
    required this.deadline,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scholarshipName),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'University: $universityName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Department: $department',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 8),
            Text(
              'Apply Date: $applyDate',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Deadline: $deadline',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            SizedBox(height: 16),
            Text(
              'Scholarship Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement application process
                },
                child: Text('Apply Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
