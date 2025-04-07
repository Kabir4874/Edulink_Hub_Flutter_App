// app_drawer.dart

import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile.jpg'), // Profile image
                ),
                SizedBox(height: 10),
                Text(
                  'John Doe',  // Replace with actual user name
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'johndoe@example.com',  // Replace with actual user email
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('University Admission'),
            onTap: () {
              Navigator.pushNamed(context, '/admission');
            },
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('Funding Support'),
            trailing: Icon(Icons.workspace_premium, size: 30, color: Colors.amber.shade700),
            onTap: () {
              Navigator.pushNamed(context, '/subscription');
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Books & PDFs'),
            onTap: () {
              Navigator.pushNamed(context, '/books');
            },
          ),
          Divider(),  // Optional divider for separation
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Implement the logout functionality
              _logout(context);
            },
          ),
        ],
      ),
    );
  }

  // Handle logout action
  void _logout(BuildContext context) {
    // You can add logic here to clear session, authentication token, etc.
    // For now, we're simply navigating back to the Sign-in page

    // Navigate to the Sign-In page and replace the current screen
    Navigator.pushReplacementNamed(context, '/'); // Replace with the SignInPage
  }
}
