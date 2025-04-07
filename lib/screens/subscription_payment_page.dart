import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart'; // Import the Stripe package

class SubscriptionPaymentPage extends StatefulWidget {
  @override
  _SubscriptionPaymentPageState createState() =>
      _SubscriptionPaymentPageState();
}

class _SubscriptionPaymentPageState extends State<SubscriptionPaymentPage> {
  double totalPrice = 20; // Subscription price

  @override
  void initState() {
    super.initState();
  }

  // Handle Stripe payment
  Future<void> _handleStripePayment(BuildContext context) async {
    try {
      // Step 1: Create a PaymentIntent on your backend and get the client secret
      final clientSecret =
          await _createPaymentIntent(); // This should be done via your backend

      // Step 2: Initialize the payment sheet
      await _initPaymentSheet(clientSecret);

      // Step 3: Present the payment sheet to the user
      await _presentPaymentSheet();

      // If payment was successful, show success dialog
      _showSuccessDialog(context);
    } catch (e) {
      // Handle errors during the payment process
      print("Error during Stripe payment: $e");
      _showErrorDialog(context, e.toString());
    }
  }

  // Create PaymentIntent on the backend (simulated here with Future)
  Future<String> _createPaymentIntent() async {
    // Replace with your backend logic to create a PaymentIntent and get the client secret
    await Future.delayed(Duration(seconds: 2));
    return "your_client_secret"; // You should get this from your backend
  }

  // Initialize the payment sheet with the client secret
  Future<void> _initPaymentSheet(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          applePay: true, // Add Apple Pay support if applicable
          googlePay: true, // Add Google Pay support if applicable
          style: ThemeMode.light,
          merchantDisplayName: 'Your Merchant Name',
        ),
      );
    } catch (e) {
      print("Error initializing payment sheet: $e");
      throw Exception('Failed to initialize payment sheet');
    }
  }

  // Present the payment sheet
  Future<void> _presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      print("Stripe error: ${e.error.localizedMessage}");
      throw e.error.localizedMessage;
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
              Navigator.pushReplacementNamed(
                  context, '/funding'); // Navigate to funding page
            },
            child: Text("Go to Funding Page"),
          ),
        ],
      ),
    );
  }

  // Show failure dialog with error details
  void _showFailureDialog(BuildContext context, String errorMessage) {
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
        content: Text("There was an issue with your payment: $errorMessage"),
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

  // Show error dialog with unexpected error details
  void _showErrorDialog(BuildContext context, String errorMessage) {
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
        content: Text("An unexpected error occurred: $errorMessage"),
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.workspace_premium,
                    size: 60, color: Colors.amber.shade700),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () => _handleStripePayment(context),
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
