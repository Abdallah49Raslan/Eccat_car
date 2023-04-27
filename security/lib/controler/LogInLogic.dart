// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:security/page/Authintication/login_page.dart';
import '../page/onboding/onboding_screen.dart';
import '../page/started_pages/Customer/Custom_start.dart';
import '../page/started_pages/Driver/Driver_start.dart';
import '../page/started_pages/Owner/Owner_start.dart';

class LoginLogic extends StatelessWidget {
  final String? email;
  final String? password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Show a login form or other content if the login process has not started yet
          return const OnboardingScreen();
        }
      },
    );
  }

  Future<bool> signInUser(BuildContext context) async {
    try {
      UserCredential? userCredential;

      if (email != null && password != null) {
        // Sign in with email and password
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline),
                const SizedBox(width: 10),
                const Text('Email or password is null'),
              ],
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return false;
      }

      if (userCredential != null) {
        // Check user's role in Cloud Firestore
        String? user = null; // Declare the role variable before using it
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userCredential.user!.uid)
                .get();

        if (documentSnapshot != null && documentSnapshot.exists) {
          user = documentSnapshot.data()!['user'];

          // Navigate to the appropriate start page based on user's role
          if (user == 'Owner') {
            
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OwnerStartPage()),
            );
          } else if (user == 'Driver') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DriverStartPage()),
            );
          } else if (user == 'Customer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CustomerStartPage()),
            );
          } else {
            // If role is not recognized, show an error message and return false
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error_outline),
                    const SizedBox(width: 10),
                    const Text('User role not recognized'),
                  ],
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
            return false;
          }
        } else {
          // If user document does not exist, show an error message and return false
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline),
                  const SizedBox(width: 10),
                  const Text('User document not found in Cloud Firestore'),
                ],
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return false;
        }

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
              const Icon(Icons.error_outline),
              const SizedBox(width: 10),
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
              const Icon(Icons.error_outline),
              const SizedBox(width: 10),
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
