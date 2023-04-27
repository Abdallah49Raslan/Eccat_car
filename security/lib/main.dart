import 'package:security/page/Authintication/login_page.dart';
import 'package:security/page/Authintication/sign_up.dart';
import 'package:security/page/Health%20Care/darkmode.dart';
import 'package:security/page/User_Profile.dart';
import 'package:security/page/onboding/onboding_screen.dart';
import 'package:security/page/spalsh_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:security/page/Health%20Care/darkmode.dart';
import 'package:security/page/Iot/mainpage.dart';
import 'package:security/page/Owner/Owner_start.dart';
import 'package:security/page/spalsh_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';
=======
import 'entry_point.dart';
>>>>>>> 23ed3eb9e21ebfd045f136dcd040d458c66fa682
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
<<<<<<< HEAD
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? role = prefs.getString('role');
  Widget startPage;
  if (role == null) {
    startPage = LoginPage();
  } else if (role == 'owner') {
    startPage = OwnerStartPage();
  } else if (role == 'driver') {
    startPage = Desert();
  } else if (role == 'customer') {
    startPage = CustomerStartPage();
  } else {
    startPage = LoginPage();
  }
  runApp(MyApp(startPage));
=======
  runApp(const MyApp());
>>>>>>> 23ed3eb9e21ebfd045f136dcd040d458c66fa682
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
<<<<<<< HEAD
      home: Desert(),
      routes: {
        'darkmode':(context)=>darkmode(),
        'iot':(context) => IoTPage()
      },
=======
      home: const OnboardingScreen(),
>>>>>>> 23ed3eb9e21ebfd045f136dcd040d458c66fa682
    );
  }
}
