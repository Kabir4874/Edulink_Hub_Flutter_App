import 'package:flutter/material.dart';
import 'package:edulinkhub/widget/admin_drawer.dart'; // Import the drawer file

class AdminBooksManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Books & PDFs'),
        backgroundColor: Colors.red.shade300,
      ),
      drawer: AdminDrawer(),
      body: Center(
        child: Text(
          'Books & PDFs Management Page',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
