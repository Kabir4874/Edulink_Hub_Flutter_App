import 'package:flutter/material.dart';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;

  OTPVerificationPage({required this.phoneNumber});

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final _otpController = TextEditingController();
  bool _isVerifying = false;

  void _verifyOTP() async {
    setState(() {
      _isVerifying = true;
    });

    await Future.delayed(Duration(seconds: 2)); // Simulating OTP verification

    setState(() {
      _isVerifying = false;
    });

    // After successful OTP verification, navigate to home page
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OTP Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter the OTP sent to ${widget.phoneNumber}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'OTP Code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            _isVerifying
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _verifyOTP,
              child: Text('Verify OTP'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Resend OTP functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('OTP Resent to ${widget.phoneNumber}')),
                );
              },
              child: Text('Resend OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
