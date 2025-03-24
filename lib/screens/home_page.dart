import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EduLink Hub - Home'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to EduLink Hub!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to University Admission Links
                Navigator.pushNamed(context, '/admission');
              },
              child: Text('University Admission Links'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Funding Support
                Navigator.pushNamed(context, '/funding');
              },
              child: Text('Funding Support'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Books & PDFs
                Navigator.pushNamed(context, '/books');
              },
              child: Text('Books & PDFs'),
            ),
          ],
        ),
      ),
    );
  }
}