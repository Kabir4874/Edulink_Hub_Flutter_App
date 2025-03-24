import 'package:flutter/material.dart';

class FundingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Funding Support'),
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
                labelText: 'Search Scholarships or Professors',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            ),
            SizedBox(height: 16),
            // Tabs for Scholarships and Professors
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Scholarships & Grants'),
                      Tab(text: 'Professors'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6, // Adjust height as needed
                    child: TabBarView(
                      children: [
                        // Scholarships & Grants Section
                        ListView.builder(
                          itemCount: 10, // Replace with actual data
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: Icon(Icons.school, color: Colors.blue),
                                title: Text('Scholarship ${index + 1}'),
                                subtitle: Text('Deadline: DD/MM/YYYY'),
                                trailing: IconButton(
                                  icon: Icon(Icons.notifications),
                                  onPressed: () {
                                    // Implement notification for deadline
                                  },
                                ),
                                onTap: () {
                                  // Navigate to scholarship details
                                },
                              ),
                            );
                          },
                        ),
                        // Professors Section
                        ListView.builder(
                          itemCount: 10, // Replace with actual data
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: Icon(Icons.person, color: Colors.green),
                                title: Text('Professor ${index + 1}'),
                                subtitle: Text('Field: Computer Science'),
                                trailing: IconButton(
                                  icon: Icon(Icons.message),
                                  onPressed: () {
                                    // Implement contact functionality
                                  },
                                ),
                                onTap: () {
                                  // Navigate to professor details
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}