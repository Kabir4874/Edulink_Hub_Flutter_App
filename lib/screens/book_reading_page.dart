import 'package:flutter/material.dart';
import 'package:edulinkhub/model/book.dart';

class BookReadingPage extends StatelessWidget {
  final Book book;

  const BookReadingPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
        backgroundColor: Colors.blue.shade300,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chapter 1: Introduction',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              // Replace this with actual content from API or local file
              '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
              Sed euismod, nisl eget consectetur sagittis, nisl nunc 
              consectetur nisi, euismod aliquam nunc nisl euismod. 
              Curabitur id suscipit ex. Suspendisse rhoncus laoreet leo 
              nec venenatis. Aenean fermentum est ut justo suscipit, 
              nec convallis mauris tincidunt.''',
              style: TextStyle(fontSize: 16, height: 1.6),
            ),
            // Add more chapters/sections here
          ],
        ),
      ),
    );
  }
}

