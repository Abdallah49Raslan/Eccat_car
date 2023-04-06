import 'package:auth_app/page/login_page.dart';
import 'package:auth_app/page/start_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginLogic extends StatelessWidget {

  final String? email;
  final String? password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginLogic({
    Key? key,
    this.email,
    this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: signInUser(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading widget while waiting for the login process to finish
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Show a login form or other content if the login process has not started yet
          return LoginPage();
        }
      },
    );
  }
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    // Trigger the Google authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      // Obtain the Google auth details from the user's account
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Navigate to the start page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartPage()),
      );

      return userCredential;
    }

    return null;
  }

  Future<bool> signInUser(BuildContext context) async {
    try {
      UserCredential? userCredential;

      if (email != null && password != null) {
        // Sign in with email and password
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email!,
            password: password!
        );
      } else {
        // Sign in with Google
        userCredential = await signInWithGoogle(context);
      }

      if (userCredential != null) {
        // Navigate to the start page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StartPage()),
        );

        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (ex) {
      String errorMessage = '';
      if (ex.code == 'user-not-found') {
        errorMessage = 'User not found';
      } else if (ex.code == 'wrong-password') {
        errorMessage = 'Incorrect password';
      } else if (ex.code == 'network-request-failed') {
        errorMessage =
        'Network error. Please check your connection and try again.';
      } else if (ex.code == 'operation-not-allowed') {
        errorMessage =
        'Signing in with email and password is not enabled. Please contact the app administrator.';
      } else {
        errorMessage = 'An error occurred. Please try again later.';
        debugPrint(ex.toString()); // log the error for debugging purposes
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline),
              SizedBox(width: 10),
              Text(errorMessage),
            ],
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      return false;
    } catch (ex) {
      String errorMessage = 'An error occurred. Please try again later.';
      debugPrint(ex.toString()); // log the error for debugging purposes

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline),
              SizedBox(width: 10),
              Text(errorMessage),
            ],
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Do not navigate to the start page if there's an error
      // Return false so that the FutureBuilder shows an error message
      return false;
    }
  }
}
