import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Iot/mainpage.dart';
import '../Health Care/darkmode.dart';
import '../login_page.dart';

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
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Page 2'),
        actions: [
          PopupMenuButton(
            // Use PopupMenuButton to show the menu options
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  title: const Text('Health Care'),
                  onTap: () {
                    Navigator.pop(context); // Close the menu
                    _showHealthCare(
                        context); // Call the callback function on button press
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: const Text('IoT'),
                  onTap: () {
                    Navigator.pop(context); // Close the menu
                    _showIoT(
                        context); // Call the callback function on button press
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                'Log out',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
