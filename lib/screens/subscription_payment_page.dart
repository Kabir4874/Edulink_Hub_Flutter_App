import 'package:edulinkhub/screens/stripe_service.dart';
import 'package:flutter/material.dart';

class SubscriptionPaymentPage extends StatefulWidget {
  const SubscriptionPaymentPage({super.key});
  @override
  State<SubscriptionPaymentPage> createState( ) => _SubscriptionPaymentPageState();
}


class _SubscriptionPaymentPageState extends State<SubscriptionPaymentPage> {
  String amount = '5000';
  String currency = 'USD';

  /*// Simulated payment handler
  void _handlePayment(BuildContext context) {
    _showSuccessDialog(context);
  }

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
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/funding');
            },
            child: Text("Go to Funding Page"),
          ),
        ],
      ),
    );
  }

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
              Navigator.pop(context);
            },
            child: Text("Try Again"),
          ),
        ],
      ),
    );
  }

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
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
*/
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.workspace_premium, size: 60,
                    color: Colors.amber.shade700),
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
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: ()async {
                    try {
                      await StripeService.initPaymentSheet(amount, currency);
                      await StripeService.presentPaymentSheet();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${e.toString()}"),
                        ),
                      );

                    }
                  },
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


