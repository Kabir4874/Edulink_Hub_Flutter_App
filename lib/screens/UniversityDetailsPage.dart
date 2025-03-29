import 'package:flutter/material.dart';
import 'package:edulinkhub/model/university.dart'; // Make sure to import the model
import 'package:url_launcher/url_launcher.dart';

class UniversityDetailsPage extends StatelessWidget {
  final University university;

  UniversityDetailsPage({required this.university});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(university.name),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📍 Location: ${university.location}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("🗓 Apply Date: ${university.applyDate}", style: TextStyle(fontSize: 16)),
            Text("⏳ Deadline: ${university.deadline}", style: TextStyle(fontSize: 16, color: Colors.red)),
            SizedBox(height: 16),
            // Apply Link Button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (await canLaunch(university.applyLink)) {
                    await launch(university.applyLink);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not open the link")));
                  }
                },
                child: Text("Apply Now"),
              ),
            ),
            SizedBox(height: 16),
            // Admit Card Download Date
            Text("🎫 Admit Card Download: ${university.admitCardDownload}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            // Exam Units
            Text("📝 Exam Units:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: university.examUnits.map((unit) {
                return Text("- Exam Date: $unit", style: TextStyle(fontSize: 16));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
