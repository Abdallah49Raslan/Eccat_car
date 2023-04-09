import 'package:auth_app/page/sign_up.dart';
import 'package:auth_app/page/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../controler/LogInLogic.dart';
import '../controler/SignUpLogic.dart';
import '../core/colors.dart';
import '../core/space.dart';
import '../core/text_style.dart';
import '../widget/main_button.dart';
import '../widget/text_fild.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();
  bool _isScure = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? email;
  String? password;

  GlobalKey<FormState> formKey =GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Form(
            key:formKey,
            child: Column(
              children: [
                // logo button
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const StartPage()));
                  },
                  child: IconButton(
                    icon: Image.asset('assets/image/logo.png', width: 50, height: 50), onPressed: () {  },
                  ),
                ),
                //head of page
                const SpaceVH(height: 50.0),
                const Text(
                  'Welcome Back!',
                  style: headline1,
                ),
                //text hint of page
                const SpaceVH(height: 10.0),
                const Text(
                  'Please sign in to your account',
                  style: headline3,
                ),
                //userEmail
                const SpaceVH(height: 60.0),
                textField(
                  onChanged: (data) {
                    email = data;
                  },
                  controller: userEmail,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                  hintTxt: 'Email Address',
                ),
                //Password
                textField(
                  onChanged: (data) {
                    password = data;
                  },
                  controller: userPass,
                  prefixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isScure = !_isScure;
                      });
                    },
                    icon: Icon(
                      _isScure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  isObs: _isScure,
                  keyboardType: TextInputType.visiblePassword,
                  hintTxt: 'Password',
                ),
                //forgetPass
                const SpaceVH(height: 10.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: headline3,
                      ),
                    ),
                  ),
                ),
                //LogIn Button
                const SpaceVH(height: 100.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Mainbutton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginLogic(
                                  email: email!,
                                  password: password!,
                                ),
                              ),);
                          }},
                        text: 'Sign in',
                        btnColor: blueButton,
                      ),
                      //LogIn with Google
                      const SpaceVH(height: 20.0),
                      Mainbutton(
                        onTap: () async {
                          await LoginLogic().signInWithGoogle(context);
                        },
                        text: 'Sign in with google',
                        btnColor: white,
                        image: 'google.jpg',
                        txtColor: blackBG,
                      ),
                      //switch to signUp
                      const SpaceVH(height: 20.0),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const SignUpPage()));
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Don\' have an account? ',
                              style: headline.copyWith(
                                fontSize: 14.0,
                              ),
                            ),
                            TextSpan(
                              text: ' Sign Up',
                              style: headlineDot.copyWith(
                                fontSize: 14.0,
                              ),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}