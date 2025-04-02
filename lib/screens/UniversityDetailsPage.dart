import 'package:edulinkhub/model/university.dart'; // Ensure to import the model
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UniversityDetailsPage extends StatelessWidget {
  final University university;

  UniversityDetailsPage({required this.university});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(university.name, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade400,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // University Image with Shadow
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Image.network(
                      university.imageUrl,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 220,
                          color: Colors.grey[300],
                          child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // University Information with Icons
              _infoRow(Icons.location_on, "Location", university.location),
              _infoRow(Icons.calendar_today, "Apply Date", university.applyDate),
              _infoRow(Icons.timer_off, "Deadline", university.deadline, Colors.red),
              _infoRow(Icons.card_membership, "Admit Card Download", university.admitCardDownload),
              SizedBox(height: 20),

              // Apply Now Button
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade500,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async {
                    Uri url = Uri.parse(university.applyLink);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Could not open the link"))
                      );
                    }
                  },
                  icon: Icon(Icons.open_in_browser, color: Colors.white),
                  label: Text("Apply Now", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),

              // Exam Units with Stylish Cards
              Text("📝 Exam Units:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Column(
                children: university.examUnits.map((unit) {
                  return Card(
                    color: Colors.blue.shade50,
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.date_range, color: Colors.blue.shade400),
                      title: Text("Exam Date: $unit", style: TextStyle(fontSize: 16)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to Create an Info Row
  Widget _infoRow(IconData icon, String label, String value, [Color? textColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade400, size: 24),
          SizedBox(width: 10),
          Text("$label:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 16, color: textColor ?? Colors.black)),
          ),
        ],
      ),
    );
  }
}