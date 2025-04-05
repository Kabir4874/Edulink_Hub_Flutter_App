/*
import 'package:flutter_sslcommerz/flutter_sslcommerz.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

double totalPrice = 19.99; // Set the price for the subscription

Future<void> sslcommerzPayment() async {
  try {
    // Initialize SSLCommerz with your store credentials and payment details
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        store_id: "eduli67f15a9f3f853", // Use the demo store ID for testing
        store_passwd: "eduli67f15a9f3f853@ssl", // Use the demo store password for testing
        total_amount: totalPrice, // Payment amount
        currency: SSLCurrencyType.BDT, // Currency type (BDT for Bangladesh Taka)
        tran_id: "TestTRX001", // Unique transaction ID (generate dynamically in production)
        product_category: "Digital Product", // Product category
        sdkType: SSLCSdkType.TESTBOX, // TESTBOX for sandbox environment, LIVE for production
        multi_card_name: "visa,master,bkash", // Supported cards for payment

      ),
    );

    // Start the payment process
    final response = await sslcommerz.payNow();

    // Handle different payment responses
    if (response.status == 'VALID') {
      // Payment successful
      print('Payment successful');
      print('Transaction ID: ${response.tranId}');
      print('Transaction Date: ${response.tranDate}');
      // Add any additional logic for successful payment (e.g., navigate to success page)
    } else if (response.status == 'CLOSED') {
      // Payment closed
      print('Payment was closed by the user or system');
    } else if (response.status == 'FAILED') {
      // Payment failed
      print('Payment failed');
    } else {
      // Unexpected status
      print('Unexpected response status: ${response.status}');
    }
  } catch (e) {
    // Handle any errors that occur during payment
    print('Error during payment: $e');
  }
}
*/
