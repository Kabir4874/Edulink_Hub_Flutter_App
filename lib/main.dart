import 'package:flutter/material.dart';
import 'screens/sign_in_page.dart'; // Sign-in page import
import 'screens/sign_up_page.dart'; // Sign-up page import
import 'screens/forgot_password_page.dart'; // Forgot password page
import 'screens/home_page.dart'; // Home page import
import 'screens/admission_page.dart'; // Admission page import
import 'screens/funding_page.dart'; // Funding page import
import 'screens/books_page.dart'; // Books page import
import 'screens/profile_page.dart';
import 'screens/payment_page.dart';


void main() {
  runApp(EdulearnApp());
}

class EdulearnApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduLink Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInPage(),
      routes: {
        '/signup': (context) => SignUpPage(),
        '/forgotPassword': (context) => ForgotPasswordPage(),
        '/home': (context) => HomePage(), // Add HomePage route
        '/admission': (context) => AdmissionPage(), // Placeholder for Admission Page
        '/funding': (context) => FundingPage(), // Placeholder for Funding Page
        '/books': (context) => BooksPage(), // Placeholder for Books Page
        '/profile': (context) => ProfilePage(
          fullName: "John Doe", // Replace with actual data
          email: "johndoe@example.com", // Replace with actual data
          phoneNumber: "+123456789", // Replace with actual data
        ),
        '/payment': (context) => PaymentPage(
          bookName: 'Default Book',
          price: 0.0, onPaymentSuccess: () {

        },
        ),

      },
    );
  }
}










