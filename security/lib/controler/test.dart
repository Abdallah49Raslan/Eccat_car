import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;
  bool _isSecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reset Password',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: _isSecure,
              decoration: InputDecoration(
                labelText: 'New Password',
                suffixIcon: IconButton(
                  icon: Icon(_isSecure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isSecure = !_isSecure;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Check if email is signed up
                  await FirebaseAuth.instance.fetchSignInMethodsForEmail(_emailController.text.trim());
                  // Reset password
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: _emailController.text.trim());

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'A password reset link has been sent to your email.',
                      ),
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'invalid-email') {
                    setState(() {
                      _errorMessage = 'Invalid email address.';
                    });
                  } else if (e.code == 'user-not-found') {
                    setState(() {
                      _errorMessage = 'No user found for that email address.';
                    });
                  } else {
                    setState(() {
                      _errorMessage = 'An error occurred. Please try again later.';
                    });
                  }
                } catch (e) {
                  setState(() {
                    _errorMessage = 'An error occurred. Please try again later.';
                  });
                }
              },
              child: Text('Reset Password'),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Login'),
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
