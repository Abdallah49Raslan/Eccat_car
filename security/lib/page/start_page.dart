import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:security/page/login_page.dart';
import 'package:security/page/start_page.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome!'),
      ),
    );
  }

  static Widget buildStartPage(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return StartPage();
    } else {
      // Redirect the user to the login page
      return LoginPage();
    }
  }
}
