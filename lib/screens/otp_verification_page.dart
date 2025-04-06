import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OTPVerificationPage extends StatefulWidget {
  final String email;
  final bool isFromSignup;
  const OTPVerificationPage(
      {Key? key, required this.email, required this.isFromSignup})
      : super(key: key);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final _otpController = TextEditingController();
  bool _isVerifying = false;
  bool _isResending = false;
  String? _errorMessage;

  Future<void> _verifyOTP() async {
    if (_otpController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter the OTP';
      });
      return;
    }

    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse('https://edulink-hub-backend.onrender.com/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': widget.email,
          'otp': _otpController.text,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (widget.isFromSignup) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushNamed(context, '/reset-password');

        }
      } else {
        setState(() {
          _errorMessage = responseData['message'] ?? 'OTP verification failed';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error. Please try again.';
      });
    } finally {
      setState(() {
        _isVerifying = false;
      });
    }
  }

  Future<void> _resendOTP() async {
    setState(() {
      _isResending = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8800/auth/resend-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': widget.email}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP resent to ${widget.email}')),
        );
      } else {
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(responseData['message'] ?? 'Failed to resend OTP')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error. Please try again.')),
      );
    } finally {
      setState(() {
        _isResending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Icon(
                Icons.email_outlined,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                "Verify Your Email",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "We've sent a verification code to:",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                widget.email,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 40),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '6-digit OTP',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                maxLength: 6,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: _isVerifying
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _verifyOTP,
                        child: const Text('Verify Email'),
                      ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _isResending ? null : _resendOTP,
                child: Text(
                  "Didn't receive code? Resend",
                  style: TextStyle(
                    color: _isResending ? Colors.grey : Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
