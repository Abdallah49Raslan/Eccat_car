import 'package:security/page/Authintication/login_page.dart';
import 'package:security/page/Authintication/sign_up.dart';
import 'package:security/page/Health%20Care/darkmode.dart';
import 'package:security/page/Iot/iot.dart';
import 'package:security/page/User_Profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:security/page/spalsh_Page/onboding_screen.dart';
import 'package:security/page/started_pages/Driver/driverstart.dart';
import 'firebase_options.dart';
import 'lists/chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      theme:
       themeData(),
      home: DriverStartPage()
      // const OnboardingScreen(),
    );
  }
}
