import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:test_two/Whitemode.dart';
import 'package:test_two/test.dart';
import 'package:test_two/write.dart';
import 'package:flutter/material.dart';
import 'package:test_two/fire.dart';
import 'package:test_two/whitemode.dart';
import 'package:test_two/darkmode.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseDatabase database = FirebaseDatabase.instance;
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: darkmode(),
    );
  }
}
