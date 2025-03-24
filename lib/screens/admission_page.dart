import 'package:flutter/material.dart';

class AdmissionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('University Admission Links'),
        actions: [
          // User Profile Button
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'), // Add profile image
            ),
            onPressed: () {
              // Navigate to user profile page
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Universities',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            ),
            SizedBox(height: 16),
            // Filters for Categorization
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: 'All Countries',
                    items: ['All Countries', 'USA', 'Canada', 'UK', 'Australia']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Implement country filter
                    },
                    decoration: InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: 'All Programs',
                    items: ['All Programs', 'Undergraduate', 'Postgraduate', 'Ph.D.']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Implement program type filter
                    },
                    decoration: InputDecoration(
                      labelText: 'Program Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Replace with actual data
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('University ${index + 1}'),
                      subtitle: Text('Admission Deadline: DD/MM/YYYY'),
                      trailing: IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () {
                          // Implement notification for deadline
                        },
                      ),
                      onTap: () {
                        // Navigate to university admission link
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}