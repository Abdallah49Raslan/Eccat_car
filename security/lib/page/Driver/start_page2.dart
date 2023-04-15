import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Health Care/darkmode.dart';
import '../login_page.dart';

class StartPage2 extends StatelessWidget {
  const StartPage2({Key? key}) : super(key: key);

  void _showMenu(BuildContext context) {
    // Callback function to show the menu options
    // Implement the desired menu functionality here
    print('Menu button pressed!');
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Start Page 2'),
        actions: [
          IconButton(
            // Use Icons.menu for three dashes menu icon
            icon: Icon(Icons.menu),
            onPressed: () {
              _showMenu(context); // Call the callback function on button press
            },
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
              child: const Text('Log out'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const darkmode()),
                );
              },
              child: const Text('Health Care'),
            ),
          ],
        ),
      ),
    );
  }
}
