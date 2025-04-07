import 'package:flutter/material.dart';
import 'package:edulinkhub/screens/funding_page.dart';

class SubscriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscription Plans"),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose a Plan",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildPlanCard(
                    context,
                    title: "Premium Plan",
                    price: "\$19.99/month",
                    features: [
                      "✔ All Features Unlocked",
                      "✔ Priority Support",
                      "✔ Exclusive Content"
                    ],
                    color: Colors.orange.shade200,
                    icon: Icons.workspace_premium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context,
      {required String title,
        required String price,
        required List<String> features,
        required Color color,
        required IconData icon}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: color,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 30, color: Colors.black87),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(price, style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features.map((feature) => Text(feature)).toList(),
            ),
            SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/subscription_payment');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Subscribe", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


