import 'package:flutter/material.dart';


class Book {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final List<String> reviews;

  Book({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.reviews,
  });
}



class BooksPage extends StatelessWidget {
  // Simulated book data (replace with API call)
  final List<Book> admissionBooks = [
    Book(
      id: '1',
      name: 'Admission Book 1',
      description: 'This is a book for university admission preparation.',
      imageUrl: 'https://via.placeholder.com/150',
      price: 19.99,
      reviews: ['Great book!', 'Very helpful for admission.'],
    ),
    // Add more admission books here
  ];

  final List<Book> jobExamBooks = [
    Book(
      id: '2',
      name: 'Job Exam Book 1',
      description: 'This is a book for job exam preparation.',
      imageUrl: 'https://via.placeholder.com/150',
      price: 24.99,
      reviews: ['Excellent resource!', 'Helped me crack the exam.'],
    ),
    // Add more job exam books here
  ];

  final List<Book> skillBasedBooks = [
    Book(
      id: '3',
      name: 'Skill-Based Book 1',
      description: 'This is a book for learning programming skills.',
      imageUrl: 'https://via.placeholder.com/150',
      price: 29.99,
      reviews: ['Very practical!', 'Great for beginners.'],
    ),
    // Add more skill-based books here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books & PDFs'),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
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
                labelText: 'Search Books',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            ),
            SizedBox(height: 16),
            // Tabs for Sections
            DefaultTabController(
              length: 3, // Number of tabs
              child: Column(
                children: [
                  // Tab Bar
                  TabBar(
                    labelColor: Colors.blue, // Color of the selected tab
                    unselectedLabelColor: Colors.grey, // Color of unselected tabs
                    tabs: [
                      Tab(text: 'Admission Books'),
                      Tab(text: 'Job Exam Books'),
                      Tab(text: 'Skill-Based Books'),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Tab Bar View
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6, // Adjust height as needed
                    child: TabBarView(
                      children: [
                        // Admission Books Section
                        _buildBookList(admissionBooks),
                        // Job Exam Books Section
                        _buildBookList(jobExamBooks),
                        // Skill-Based Books Section
                        _buildBookList(skillBasedBooks),
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

  // Helper method to build a book list
  Widget _buildBookList(List<Book> books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Icon(Icons.book, color: Colors.blue), // Use an icon in leading
            title: Text(book.name),
            subtitle: Text('\$${book.price.toStringAsFixed(2)}'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to the book description page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDescriptionPage(book: book),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
class BookDescriptionPage extends StatelessWidget {
  final Book book;

  BookDescriptionPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Image
            Image.network(
              book.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            // Book Name
            Text(
              book.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Book Price
            Text(
              'Price: \$${book.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 16),
            // Book Description
            Text(
              book.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Reviews
            Text(
              'Reviews',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: book.reviews.map((review) {
                return Text(
                  '- $review',
                  style: TextStyle(fontSize: 16),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            // Buy Now Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the book reading page after purchase
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookReadingPage(book: book),
                    ),
                  );
                },
                child: Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BookReadingPage extends StatelessWidget {
  final Book book;

  BookReadingPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Content (Replace with actual book content)
            Text(
              'This is the content of the book. Replace this with the actual book content fetched from the API.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}