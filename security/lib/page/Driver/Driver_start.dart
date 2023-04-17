import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Authintication/login_page.dart';
import '../Health Care/darkmode.dart';
import '../Iot/mainpage.dart';
import '../User_Profile.dart';

class DriverStartPage extends StatelessWidget {
  const DriverStartPage({Key? key}) : super(key: key);

  void _showHealthCare(BuildContext context) {
    // Callback function to navigate to Health Care page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const darkmode()),
    );
  }

  void _showIoT(BuildContext context) {
    // Callback function to navigate to IoT page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const IoTPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                'assets/image/logo.png', // Replace with your logo image path
                width: 32, // Set the width of the logo image
                height: 32, // Set the height of the logo image
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search', // Placeholder for the search box
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                // Navigate to the user's account page
                _showUserDetails(context);
              },
              icon: Icon(Icons.account_circle), // Add the account icon here
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
  void _showUserDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserDetailPage()),
    );
  }
}
