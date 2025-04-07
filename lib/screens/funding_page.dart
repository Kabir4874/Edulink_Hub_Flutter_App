import 'package:flutter/material.dart';
import 'package:edulinkhub/widget/app_drawer.dart';
import 'package:edulinkhub/screens/scholarship_detail_page.dart';
import 'package:edulinkhub/screens/professor_detail_page.dart';



class FundingPage extends StatelessWidget {
  final List<Map<String, String>> scholarships = [ // ⬅️ Add the list here
    {
      'universityName': 'Harvard University',
      'scholarshipName': 'Full Tuition Scholarship',
      'department': 'Computer Science',
      'applyDate': '01/05/2025',
      'deadline': '30/06/2025',
      'description': 'Covers full tuition fees for outstanding students in Computer Science. Requires GPA 3.5+, research experience, and recommendation letters.',
    },
    {
      'universityName': 'Stanford University',
      'scholarshipName': 'AI Research Grant',
      'department': 'Artificial Intelligence',
      'applyDate': '15/06/2025',
      'deadline': '15/07/2025',
      'description': 'Supports AI research students with a \$10,000 grant. Open to PhD and MSc students specializing in AI, Machine Learning, or Data Science.',
    },
    {
      'universityName': 'MIT',
      'scholarshipName': 'Women in Tech Fellowship',
      'department': 'Software Engineering',
      'applyDate': '10/07/2025',
      'deadline': '30/08/2025',
      'description': 'Aimed at female students pursuing careers in tech. Includes mentorship, financial aid, and industry exposure. Requires project submission.',
    },
    {
      'universityName': 'Oxford University',
      'scholarshipName': 'Global Leaders Scholarship',
      'department': 'Business Administration',
      'applyDate': '05/04/2025',
      'deadline': '10/05/2025',
      'description': 'A prestigious scholarship for business students demonstrating leadership. Covers 50% tuition fees and includes a leadership bootcamp.',
    },
    {
      'universityName': 'University of Toronto',
      'scholarshipName': 'International Excellence Award',
      'department': 'Mechanical Engineering',
      'applyDate': '20/03/2025',
      'deadline': '20/04/2025',
      'description': 'Awarded to international students excelling in Mechanical Engineering. Provides \$5,000 per semester and research opportunities.',
    },
  ];


  final List<Map<String, String>> professors = [
    {
      'name': 'Dr. Alice Johnson',
      'field': 'Artificial Intelligence',
      'workingArea': 'Deep Learning, NLP',
      'description': 'Dr. Alice Johnson is a leading researcher in AI and deep learning, currently working on explainable AI models.',
      'profileUrl': 'https://example.com/alice-profile',
      'imageUrl': 'https://example.com/alice-photo.jpg',
    },
    {
      'name': 'Dr. Robert Smith',
      'field': 'Cybersecurity',
      'workingArea': 'Network Security, Cryptography',
      'description': 'Dr. Robert Smith specializes in cybersecurity, with research focusing on cryptographic algorithms and secure networks.',
      'profileUrl': 'https://example.com/robert-profile',
      'imageUrl': 'https://example.com/robert-photo.jpg',
    },
    {
      'name': 'Dr. Emily Brown',
      'field': 'Data Science',
      'workingArea': 'Big Data, Statistical Modeling',
      'description': 'Dr. Emily Brown is known for her contributions to statistical modeling and big data analytics.',
      'profileUrl': 'https://example.com/emily-profile',
      'imageUrl': 'https://example.com/emily-photo.jpg',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Funding Support'),
        actions: [
          // User Profile Button
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'), // Add profile image
            ),
            onPressed: () {
              // Navigate to user profile page when profile image is tapped
              Navigator.pushNamed(
                context,
                '/profile',
                arguments: {
                  'fullName': 'John Doe',  // Example data
                  'email': 'johndoe@example.com',
                  'phoneNumber': '+123456789',
                },
              );
            },
          )

        ],

        backgroundColor: Colors.blue.shade300,
      ),
      drawer: AppDrawer(),
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
                    itemCount: scholarships.length,
                      itemBuilder: (context, index) {
                        final scholarship = scholarships[index];

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Icon(Icons.school, color: Colors.blue),
                            title: Text(scholarship['scholarshipName'] ?? 'Unknown Scholarship'), // ✅ Handle Null
                            subtitle: Text('Deadline: ${scholarship['deadline'] ?? 'No deadline'}'), // ✅ Handle Null
                            trailing: IconButton(
                              icon: Icon(Icons.notifications),
                              onPressed: () {
                                // Implement notification for deadline
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScholarshipDetailPage(
                                    universityName: scholarship['universityName'] ?? 'Unknown University',
                                    scholarshipName: scholarship['scholarshipName'] ?? 'Scholarship',
                                    department: scholarship['department'] ?? 'Not Specified',
                                    applyDate: scholarship['applyDate'] ?? 'Not Available',
                                    deadline: scholarship['deadline'] ?? 'Not Available',
                                    description: scholarship['description'] ?? 'No description provided.',
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),


                    // Professors Section
                    ListView.builder(
                      itemCount: professors.length, // Use the professors list
                      itemBuilder: (context, index) {
                        final professor = professors[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(professor['imageUrl']!),
                            ),
                            title: Text(professor['name']!),
                            subtitle: Text('Field: ${professor['field']}'),
                            trailing: IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {
                                // Implement messaging or contact functionality
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfessorDetailPage(
                                    name: professor['name']!,
                                    field: professor['field']!,
                                    workingArea: professor['workingArea']!,
                                    description: professor['description']!,
                                    profileUrl: professor['profileUrl']!,
                                    imageUrl: professor['imageUrl']!,
                                  ),
                                ),
                              );
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