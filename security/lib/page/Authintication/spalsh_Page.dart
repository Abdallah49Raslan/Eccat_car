import 'package:flutter/material.dart';
import 'package:security/core/colors.dart';
import 'package:security/core/text_style.dart';
import '../../core/space.dart';
import '../../data/demo.dart';
import '../../widget/main_button.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          //start image
          Container(
            height: height,
            color: blackBG,
            child: Image.asset(
              'assets/image/home_page.jpg',
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height / 3,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),

              //start text
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: 'ECCAT CAR',
                        style: headline,
                      ),
                      TextSpan(
                        text: '.',
                        style: headlineDot,
                      ),
                    ]),
                  ),

                  const SpaceVH(height: 20.0),
                  Text(
                    splashText,
                    textAlign: TextAlign.center,
                    style: headline2,
                  ),

                  //start Button to go LoginPage
                  Mainbutton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const LoginPage()));
                    },
                    btnColor: blueButton,
                    text: 'Get Started',
                  ),
                  const SpaceVH(height: 30.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
