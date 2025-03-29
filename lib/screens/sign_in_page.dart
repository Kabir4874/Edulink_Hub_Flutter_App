import 'package:flutter/material.dart';

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

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate a network call for sign-in
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign In Successful!')),
      );

      // Navigate to the Home Page
      Navigator.pushReplacementNamed(context, '/home');
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
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // Forgot Password link
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgotPassword');
                  },
                  child: Text('Forget Password?'),
                ),

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/images/google.png', height: 24), // Google icon
                      onPressed: () {
                        // Handle Google sign-in
                      },
                    ),
                    IconButton(
                      icon: Image.asset('assets/images/facebook.png', height: 24), // Facebook icon
                      onPressed: () {
                        // Handle Facebook sign-in
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.0),*/

                // Sign-up Link
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
}
