import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red.shade300,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/images/admin_profile.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  'Admin Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'admin@example.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard, color: Colors.red.shade600),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushNamed(context, '/admin-dashboard');
            },
          ),
          ListTile(
            leading: Icon(Icons.add, color: Colors.red.shade600),
            title: Text('Add University'),
            onTap: () {
              Navigator.pushNamed(context, '/admin-admission-management');
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt, color: Colors.red.shade600),
            title: Text('All University List'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/admin-admission-list',
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.school, color: Colors.red.shade600),
            title: Text('Add Scholarship'),
            onTap: () {
              Navigator.pushNamed(context, '/add-scholarship');
            },
          ),
          ListTile(
            leading: Icon(Icons.list, color: Colors.red.shade600),
            title: Text('All Scholarship List'),
            onTap: () {
              Navigator.pushNamed(context, '/scholarship-list');
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add, color: Colors.red.shade600),
            title: Text('Add Professor'),
            onTap: () {
              Navigator.pushNamed(context, '/add-professor');
            },
          ),
          ListTile(
            leading: Icon(Icons.people, color: Colors.red.shade600),
            title: Text('All Professor List'),
            onTap: () {
              Navigator.pushNamed(context, '/professor-list');
            },
          ),
          ListTile(
            leading: Icon(Icons.book, color: Colors.red.shade600),
            title: Text('Manage Books'),
            onTap: () {
              Navigator.pushNamed(context, '/admin-books-management');
            },
          ),
          ListTile(
            leading: Icon(Icons.analytics, color: Colors.red.shade600),
            title: Text('View Reports'),
            onTap: () {
              Navigator.pushNamed(context, '/admin-reports');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red.shade600),
            title: Text('Logout'),
            onTap: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/admin-signin');
  }
}
