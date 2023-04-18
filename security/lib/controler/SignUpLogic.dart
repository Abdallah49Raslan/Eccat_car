import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:security/page/Authintication/sign_up.dart';
import '../page/Customer/Custom_start.dart';
import '../page/Driver/Driver_start.dart';

class SignUpLogic extends StatelessWidget {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String role;
  final String personId;
  final String driverLicense;

  const SignUpLogic({
    Key? key,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.role,
    required this.personId,
    required this.driverLicense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: createUser(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading widget while waiting for the sign-up process to finish
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData && snapshot.data!) {
          // Check the user role and navigate to the appropriate start page
          if (role == 'Driver') {
            return DriverStartPage();
          } else if (role == 'Customer') {
            return CustomerStartPage();
          }
        } else if (snapshot.hasError) {
          // Handle any errors that may occur during sign-up
          return Text('Error: ${snapshot.error}');
        }

        // Add a default return statement to ensure that the return type is non-nullable
        return SignUpPage();
      },
    );
  }

  Future<bool> createUser(BuildContext context) async {
    try {
      // check if email already exists in Firebase Auth
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        // show error message using SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline),
                SizedBox(width: 10),
                Text('Email already exists'),
              ],
            ),
            behavior: SnackBarBehavior.floating, // set behavior to floating
          ),
        );
        return false;
      }

      // create user with email and password
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // create user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user!.uid)
          .set({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'user': role,
        'Driver ID': personId,
        'Driver License Number': driverLicense,
      });

      return true;
    } on FirebaseAuthException catch (ex) {
      // show error message using SnackBar
      String errorMessage = '';
      if (ex.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (ex.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (ex.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = 'Something went wrong. Please try again later.';
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
          behavior: SnackBarBehavior.floating, // set behavior to floating
        ),
      );
      return false;
    } catch (ex) {
      // if an unexpected error occurs, rethrow it
      rethrow;
    }
  }
}
