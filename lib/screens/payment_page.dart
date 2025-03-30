import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final String bookName;
  final double price;
  final VoidCallback onPaymentSuccess; // Callback to update purchase status

  PaymentPage({required this.bookName, required this.price, required this.onPaymentSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book: $bookName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Total Price: \$${price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 16),
            // Payment Method Selection
            Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Credit / Debit Card'),
              onTap: () {
                _processPayment(context, 'Credit/Debit Card');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Mobile Wallet (e.g., PayPal, GPay)'),
              onTap: () {
                _processPayment(context, 'Mobile Wallet');
              },
            ),
            ListTile(
              leading: Icon(Icons.payments),
              title: Text('Cash on Delivery'),
              onTap: () {
                _processPayment(context, 'Cash on Delivery');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _processPayment(BuildContext context, String method) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Processing payment via $method...')),
    );

    bool success = await _startPayment(context);

    if (success) {
      onPaymentSuccess(); // Mark book as purchased
      Navigator.pop(context); // Close payment page
    }
  }

  Future<bool> _startPayment(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate payment processing

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Successful! You can now read the book.')),
    );

    return true; // Simulating successful payment
  }
}
