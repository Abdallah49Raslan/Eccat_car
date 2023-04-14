import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../login_page.dart';

class StartPage2 extends StatelessWidget {
  const StartPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final userData = snapshot.data!.data() as Map<String, dynamic>?;
                final userName = userData?['name'] as String?;
                return Text(
                  'Welcome ${userName ?? 'Driver'}!',
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
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
          ],
        ),
      ),
    );
  }
}