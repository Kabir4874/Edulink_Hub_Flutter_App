import 'dart:convert';

import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
=======
>>>>>>> c298b122af1cf48bae3a7dea1c2179d9b9a64d94

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;

  // Function to save token
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    // You can also save other user data if needed
    // await prefs.setString('user_email', _emailController.text.trim());
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final response = await http.post(
          Uri.parse('https://edulink-hub-backend.onrender.com/auth/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': _emailController.text.trim(),
            'password': _passwordController.text,
          }),
        );

        final responseData = jsonDecode(response.body);

        if (response.statusCode == 200) {
          // Extract token from response (adjust according to your API response structure)
          final token = responseData['token'] ??
              responseData['accessToken'] ??
              responseData['data']['token'];

          if (token != null) {
            await _saveToken(token);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sign In Successful!')),
            );

            Navigator.pushReplacementNamed(context, '/home');
          } else {
            setState(() {
              _errorMessage = 'Token not received from server';
            });
          }
        } else {
          setState(() {
            _errorMessage =
                responseData['message'] ?? 'Login failed. Please try again.';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Network error. Please check your connection.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
<<<<<<< HEAD
                  'assets/images/logo.png',
                  height: 300,
                  width: 300,
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email or User Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or username';
=======
                  'assets/images/logo.png', // Replace with your logo path
                  height: 300, // Adjust height as needed
                  width: 300, // Adjust width as needed
                ),
                SizedBox(height: 10),
                // Email or Username Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email or User Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or username';
                    }
                    // Validate email format
                    final emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    // Password validation: at least 6 characters, one uppercase letter, one number, one special character
                    final passwordRegExp = RegExp(
                        r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:\'",<>\./?\\|`~]).{6,}"
                            );
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    if (!passwordRegExp.hasMatch(value)) {
                      return 'Password must contain at least 1 uppercase letter, 1 number, and 1 special character';
>>>>>>> c298b122af1cf48bae3a7dea1c2179d9b9a64d94
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
<<<<<<< HEAD
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    // if (value.length < 6) {
                    //   return 'Password must be at least 6 characters';
                    // }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
=======

                // Forgot Password link
>>>>>>> c298b122af1cf48bae3a7dea1c2179d9b9a64d94
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgotPassword');
                  },
                  child: Text('Forget Password?'),
                ),
<<<<<<< HEAD
                SizedBox(height: 8.0),
                _isLoading
                    ? CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _signIn,
                          child: Text('Sign In'),
                        ),
                      ),
                SizedBox(height: 16.0),
                Text('Or sign in with'),
                SizedBox(height: 16.0),
=======

                // Sign-in Button or Loading Indicator
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _signIn,
                  child: Text('Log In'),
                ),
                SizedBox(height: 16.0),

                /*// Or sign in with
                Text('Or sign in with'),
                SizedBox(height: 16.0),

                // Social Media Sign-in Buttons (Google/Facebook)
>>>>>>> c298b122af1cf48bae3a7dea1c2179d9b9a64d94
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
<<<<<<< HEAD
                      icon: Image.asset('assets/images/google.png', height: 24),
=======
                      icon: Image.asset('assets/images/google.png', height: 24), // Google icon
>>>>>>> c298b122af1cf48bae3a7dea1c2179d9b9a64d94
                      onPressed: () {
                        // Handle Google sign-in
                      },
                    ),
                    IconButton(
<<<<<<< HEAD
                      icon:
                          Image.asset('assets/images/facebook.png', height: 24),
=======
                      icon: Image.asset('assets/images/facebook.png', height: 24), // Facebook icon
>>>>>>> c298b122af1cf48bae3a7dea1c2179d9b9a64d94
                      onPressed: () {
                        // Handle Facebook sign-in
                      },
                    ),
                  ],
                ),
<<<<<<< HEAD
                SizedBox(height: 16.0),
=======
                SizedBox(height: 16.0),*/

                // Sign-up Link
>>>>>>> c298b122af1cf48bae3a7dea1c2179d9b9a64d94
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text('Don\'t have an account? Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
=======
>>>>>>> c298b122af1cf48bae3a7dea1c2179d9b9a64d94
}
