import 'package:security/page/Authintication/login_page.dart';
import 'package:security/page/Customer/Custom_start.dart';
import 'package:security/page/Driver/Driver_start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:security/page/Owner/Owner_start.dart';
import 'package:security/page/spalsh_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? role = prefs.getString('role');
  Widget startPage;
  if (role == null) {
    startPage = LoginPage();
  } else if (role == 'owner') {
    startPage = OwnerStartPage();
  } else if (role == 'driver') {
    startPage = DriverStartPage();
  } else if (role == 'customer') {
    startPage = CustomerStartPage();
  } else {
    startPage = LoginPage();
  }
  runApp(MyApp(startPage));
}

class MyApp extends StatelessWidget {
  final Widget startPage;

  const MyApp(this.startPage);

  ThemeData themeData() {
    // Define your theme data here
    return ThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: startPage,
    );
  }
}
