
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

import 'package:url_launcher/url_launcher.dart';

class UniversityDetailsPage extends StatefulWidget {
  final String universityId;

  UniversityDetailsPage({required this.universityId});

  @override
  _UniversityDetailsPageState createState() => _UniversityDetailsPageState();
}

class _UniversityDetailsPageState extends State<UniversityDetailsPage> {
  late Map<String, dynamic> university;

  @override
  void initState() {
    super.initState();
    university = {};
    fetchUniversityDetails();
  }

  Future<void> fetchUniversityDetails() async {
    final response = await http.get(Uri.parse(
        'https://edulink-hub-backend.onrender.com/university/get/${widget.universityId}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          university = data['university'] ?? {};
        });
      }
    }
  }

  String formatDate(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr);
      return intl.DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (university.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
          backgroundColor: Colors.blue.shade300,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    String name = university['name'] ?? 'Unknown University';
    String location = university['location'] ?? 'Location not available';
    String programType = university['programType'] ?? 'Not Available';
    String discipline = university['discipline'] ?? 'Not Available';
    String applyDate = university['applicationDate'] ?? 'Not Available';
    String deadline = university['applicationDeadline'] ?? 'Not Available';
    String admitCardDownload =
        university['admitCardDownloadDate'] ?? 'Not Available';
    String applyLink = university['admissionLink'] ?? '#';
    String imageUrl =
        university['imageUrl'] ?? 'https://via.placeholder.com/150';
    List examUnits = university['examUnits'] ?? [];

    return Scaffold(
      appBar: AppBar(

        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),

        backgroundColor: Colors.blue.shade400,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      imageUrl,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 220,
                          color: Colors.grey[300],
                          child: Icon(Icons.image_not_supported,
                              size: 50, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _infoRow(Icons.location_on, "Location", location),
              _infoRow(Icons.school, "Program Type", programType),
              _infoRow(Icons.book, "Discipline", discipline),
              _infoRow(
                  Icons.calendar_today, "Apply Date", formatDate(applyDate)),
              _infoRow(Icons.timer_off, "Deadline", formatDate(deadline),
                  Colors.red),
              _infoRow(Icons.card_membership, "Admit Card Download",
                  formatDate(admitCardDownload)),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade500,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async {
                    Uri url = Uri.parse(applyLink);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Could not open the link")));
                    }
                  },
                  icon: Icon(Icons.open_in_browser, color: Colors.white),
                  label: Text("Apply Now",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              Text("📝 Exam Units:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Column(
                children: examUnits.map<Widget>((unit) {
                  return Card(
                    color: Colors.blue.shade50,
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading:
                          Icon(Icons.date_range, color: Colors.blue.shade400),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Unit: ${unit['unit'] ?? 'Unknown Unit'}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Exam Date: ${formatDate(unit['date'] ?? '')}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value,
      [Color? textColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade400, size: 24),
          SizedBox(width: 10),
          Text("$label:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style:
                    TextStyle(fontSize: 16, color: textColor ?? Colors.black)),
          ),
        ],
      ),
    );
  }
}

