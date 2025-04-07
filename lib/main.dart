import 'package:edulinkhub/screens/reset_pass_page.dart';
import 'package:flutter/material.dart';

import 'screens/admission_page.dart';
import 'screens/books_page.dart';
import 'screens/forgot_password_page.dart';
import 'screens/funding_page.dart';
import 'screens/home_page.dart';
import 'screens/sign_in_page.dart';
import 'screens/sign_up_page.dart';
import 'screens/subscription_page.dart';
import 'screens/subscription_payment_page.dart';
// import 'screens/Admin/admin_sign_in_page.dart';
// import 'screens/Admin/admin_dashboard_page.dart';
// import 'screens/Admin/admin_admission_management_page.dart';
// import 'screens/Admin/admin_admission_list_page.dart';
// import 'screens/Admin/add_professor_page.dart';
// import 'screens/Admin/add_scholarship_page.dart';
// import 'screens/Admin/all_professor_list_page.dart';
// import 'screens/Admin/all_scholarship_list_page.dart';

// import 'screens/Admin/admin_books_management_page.dart';

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
        '/home': (context) => HomePage(),
        '/admission': (context) => AdmissionPage(),
        '/funding': (context) => FundingPage(),
        '/books': (context) => BooksPage(),
        '/subscription': (context) => SubscriptionPage(),
        '/subscription_payment': (context) => SubscriptionPaymentPage(),
        '/reset-password': (context) => ResetPasswordPage(),
        // '/admin-signin': (context) => AdminSignInPage(),
        // '/admin-dashboard': (context) => AdminDashboardPage(),
        // '/admin-admission-management': (context) => AdminAdmissionManagementPage(),
        // '/admin-admission-list': (context) => AdminAdmissionListPage(admissions: [],),

        // '/add-scholarship': (context) => AddScholarshipPage(),
        // "/scholarship-list": (context) => AllScholarshipListPage(scholarships: [],),

        // '/add-professor': (context) => AddProfessorPage(),
        // '/professor-list': (context) => AllProfessorListPage(professors: [],),
        // '/admin-books-management': (context) => AdminBooksManagementPage(),
      },
    );
  }
}
