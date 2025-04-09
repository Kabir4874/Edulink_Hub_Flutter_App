import 'package:flutter/material.dart';
import 'package:edulinkhub/model/book.dart';
import 'package:edulinkhub/screens/book_reading_page.dart';
import 'package:edulinkhub/screens/payment_page.dart';

class BookDescriptionPage extends StatefulWidget {
  final Book book;

  const BookDescriptionPage({Key? key, required this.book}) : super(key: key);

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
    _reviews = List.from(widget.book.reviews);
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
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.book.name,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Price: \$${widget.book.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18, color: Colors.green.shade700)),
                    SizedBox(height: 16),
                    Text(widget.book.description,
                        style: TextStyle(fontSize: 16, height: 1.5)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('User Reviews', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ..._reviews.map((review) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.person, size: 20, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(child: Text(review, style: TextStyle(fontSize: 16))),
                ],
              ),
            )),
            SizedBox(height: 30),
            Form(
              key: _reviewFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Write a Review',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Review cannot be empty' : null,
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
