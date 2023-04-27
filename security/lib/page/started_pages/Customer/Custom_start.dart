import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:security/controler/test.dart';
import 'package:security/page/Authintication/login_page.dart';
import '../../../firebaseService.dart';
import '../../onboding/onboding_screen.dart';
import '../Customer/location.dart';


class CustomerStartPage extends StatelessWidget {
  const CustomerStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseService _service = FirebaseService();
    //LocationService _locationService = LocationService();

    double _latitude = 0;
    double _longitude = 0;

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
       // _locationService.sendLocationToDatabase(context);
      }),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final userData = snapshot.data!.data() as Map<String, dynamic>?;
                final userName = userData?['name'] as String?;
                return Text(
                  'Welcome ${userName ?? 'Owner'}!',
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
            const SizedBox(height: 16),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationPage()),
                );
              },
              icon: Icon(Icons.location_on),
              tooltip: 'Go to Location Page',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const OnboardingScreen()),
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