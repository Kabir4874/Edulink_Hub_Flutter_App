import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/flutter_sslcommerz.dart'; // Import SSLCommerz package
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

class SubscriptionPaymentPage extends StatelessWidget {
  // Define the price for the subscription
  double totalPrice = 19.99;

  // Handle the SSLCommerz payment process
  Future<void> _handleSslPayment(BuildContext context) async {
    try {
      // Initialize SSLCommerz with your store credentials and payment details
      Sslcommerz sslcommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
          store_id: "eduli67f15a9f3f853", // Store ID from SSLCommerz
          store_passwd: "eduli67f15a9f3f853@ssl", // Store password from SSLCommerz
          total_amount: totalPrice, // Payment amount
          currency: SSLCurrencyType.BDT, // Currency type (BDT for Bangladesh Taka)
          tran_id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique transaction ID
          product_category: "Digital Product", // Product category
          sdkType: SSLCSdkType.TESTBOX, // TESTBOX for sandbox environment
          multi_card_name: "visa,master,bkash", // Supported payment methods

        ),
      );

      // Start the payment process and open the WebView for SSLCommerz payment
      final response = await sslcommerz.payNow();

      // Listen to the result and handle different responses
      if (response != null && response.status == 'VALID') {
        _showSuccessDialog(context);
      } else {
        // If payment status is not VALID, show failure dialog
        _showFailureDialog(context);
      }
    } catch (e) {
      // Handle any errors during the payment process
      print('Error during payment: $e');
      _showErrorDialog(context);
    }
  }

  // Show success dialog
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 10),
            Text("Payment Successful"),
          ],
        ),
        content: Text("You are now a Premium Member. Enjoy the benefits!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacementNamed(context, '/funding'); // Navigate to funding page
            },
            child: Text("Go to Funding Page"),
          ),
        ],
      ),
    );
  }

  // Show failure dialog
  void _showFailureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 10),
            Text("Payment Failed"),
          ],
        ),
        content: Text("There was an issue with your payment. Please try again."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: Text("Try Again"),
          ),
        ],
      ),
    );
  }

  // Show error dialog
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.orange),
            SizedBox(width: 10),
            Text("Error"),
          ],
        ),
        content: Text("An unexpected error occurred. Please try again later."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text("Premium Subscription"),
        backgroundColor: Colors.orange.shade300,
        elevation: 2,
      ),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.workspace_premium, size: 60, color: Colors.amber.shade700),
                SizedBox(height: 16),
                Text(
                  "Complete Your Payment",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  "Unlock all features and enjoy premium support with our plan.",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.attach_money, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      "Premium Plan: \$19.99/month",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () => _handleSslPayment(context),
                  icon: Icon(Icons.lock_open_rounded),
                  label: Text("Pay Now", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
