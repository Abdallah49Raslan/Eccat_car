import 'package:security/page/Authintication/login_page.dart';
import 'package:security/page/Authintication/sign_up.dart';
import 'package:security/page/Health%20Care/darkmode.dart';
import 'package:security/page/User_Profile.dart';
import 'package:security/page/spalsh_Page/onboding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'page/started_pages/Customer/entry_customer.dart';
import 'page/started_pages/Driver/entry_Driver.dart';
import 'firebase_options.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Define your theme data here
  ThemeData themeData() {
    return ThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: const OnboardingScreen(),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
    required this.largeScreen,
    required this.smallScreen,
  }) : super(key: key);

  final Widget largeScreen;
  final Widget smallScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 600) {
        // Use large screen layout
        return largeScreen;
      } else {
        // Use small screen layout
        return smallScreen;
      }
    });
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        largeScreen: Row(
          children: [
            Expanded(
              flex: 2,
              child: const EntryDriver(),
            ),
            Expanded(
              flex: 3,
              child: const EntryCustomer(),
            ),
          ],
        ),
        smallScreen: Column(
          children: const [
            EntryDriver(),
            EntryCustomer(),
          ],
        ),
      ),
    );
  }
}
