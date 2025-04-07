import 'package:flutter/material.dart';
import 'package:edulinkhub/widget/app_drawer.dart';
import 'package:edulinkhub/screens/payment_page.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';





class Book {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  final List<String> reviews;
  final String pdfUrl;
  bool isPurchased; // Track purchase status

  Book({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.reviews,
    required this.pdfUrl,
    this.isPurchased = false, // Default as not purchased
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
      pdfUrl: '', // You can leave this empty for admission books
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
      pdfUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf', // PDF URL for job exam books
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
      pdfUrl: '', // No PDF for skill-based books
    ),
    // Add more skill-based books here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books & PDFs'),
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


class BookDescriptionPage extends StatefulWidget {
  final Book book;

  BookDescriptionPage({required this.book});

  @override
  _BookDescriptionPageState createState() => _BookDescriptionPageState();
}

class _BookDescriptionPageState extends State<BookDescriptionPage> {
  final _reviewController = TextEditingController();
  final _reviewFormKey = GlobalKey<FormState>();
  List<String> _reviews = [];

  @override
  void initState() {
    super.initState();
    _reviews = List.from(widget.book.reviews); // Initialize from existing reviews
  }

  void _submitReview() {
    if (_reviewFormKey.currentState!.validate()) {
      setState(() {
        _reviews.add(_reviewController.text.trim());
        _reviewController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text('Books & PDFs'),
        backgroundColor: Colors.blue.shade300,
        elevation: 3,
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/profile',
                arguments: {
                  'fullName': 'John Doe',
                  'email': 'johndoe@example.com',
                  'phoneNumber': '+123456789',
                },
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.book.imageUrl,
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // Book Info Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.book.name,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Price: \$${widget.book.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, color: Colors.green.shade700),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.book.description,
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Reviews Display
            Text(
              'User Reviews',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ..._reviews.map((review) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.person, size: 20, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        review,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: 30),

            // Review Input Section
            Form(
              key: _reviewFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Write a Review',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _reviewController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Share your thoughts about this book...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Review cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: _submitReview,
                      icon: Icon(Icons.send),
                      label: Text('Submit Review'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade400,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Buy/Read Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (widget.book.isPurchased) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookReadingPage(book: widget.book),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          bookName: widget.book.name,
                          price: widget.book.price,
                          onPaymentSuccess: () {
                            setState(() {
                              widget.book.isPurchased = true;
                            });
                          },
                        ),
                      ),
                    );
                  }
                },
                icon: Icon(widget.book.isPurchased ? Icons.menu_book : Icons.shopping_cart),
                label: Text(
                  widget.book.isPurchased ? 'Read Now' : 'Buy Now',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.book.isPurchased
                      ? Colors.greenAccent.shade100
                      : Colors.blue.shade100,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// Book Reading Page (After purchase)
class BookReadingPage extends StatelessWidget {
  final Book book;

  BookReadingPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
        backgroundColor: Colors.blue.shade300,
      ),
      body: SfPdfViewer.network(
        book.pdfUrl,
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}