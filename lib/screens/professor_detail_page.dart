import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfessorDetailPage extends StatelessWidget {
  final String name;
  final String field;
  final String workingArea;
  final String description;
  final String profileUrl;
  final String imageUrl;

  ProfessorDetailPage({
    required this.name,
    required this.field,
    required this.workingArea,
    required this.description,
    required this.profileUrl,
    required this.imageUrl,
  });

  void _launchURL() async {
    if (await canLaunch(profileUrl)) {
      await launch(profileUrl);
    } else {
      throw 'Could not open the profile link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name), backgroundColor: Colors.blue.shade300),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            SizedBox(height: 16),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Field: $field', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Working Area: $workingArea', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: _launchURL,
                icon: Icon(Icons.open_in_browser),
                label: Text('View Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
