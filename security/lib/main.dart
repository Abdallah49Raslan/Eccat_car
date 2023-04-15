import 'package:security/page/Driver/start_page2.dart';
import 'package:security/page/Health%20Care/darkmode.dart';
import 'package:security/page/Owner/start_page.dart';
import 'package:security/page/Customer/start_page3.dart';
import 'package:security/page/spalsh_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
      home: StartPage2(),
    );
  }
}
