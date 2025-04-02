import 'package:flutter/material.dart';
import 'package:edulinkhub/widget/app_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EduLink Hub - Home'),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),  // Add a background image
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(  // Add SingleChildScrollView to make the content scrollable
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo added here
                  Image.asset(
                    'assets/images/logo.png',  // Replace with the path to your logo image
                    height: 200,  // Adjust height as needed
                    width: 400,  // Adjust width as needed
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome to EduLink Hub!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.7),
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  _buildButton(
                    context,
                    'University Admission Links',
                    Icons.school,
                    '/admission',
                  ),
                  SizedBox(height: 20),
                  _buildButton(
                    context,
                    'Funding Support',
                    Icons.money,
                    '/subscription',
                  ),
                  SizedBox(height: 20),
                  _buildButton(
                    context,
                    'Books & PDFs',
                    Icons.book,
                    '/books',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, IconData icon, String route) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
          color: Colors.blue.shade600,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        onTap: () {
          // Navigate to the specific route
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
