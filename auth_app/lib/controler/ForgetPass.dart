import 'package:flutter/material.dart';
import 'package:auth_app/core/colors.dart';
import 'package:auth_app/core/text_style.dart';
import 'package:auth_app/widget/main_button.dart';
import 'package:auth_app/widget/text_fild.dart';
import 'package:auth_app/core/space.dart';
import 'package:auth_app/page/login_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController userEmail = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SpaceVH(height: 50.0),
                const Text(
                  'Forget Password',
                  style: headline1,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Enter your email address to reset your password',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 100.0),
                textField(
                  controller: userEmail,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                  hintTxt: 'Email Address',
                ),
                const SpaceVH(height: 200.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Mainbutton(
                        onTap: () {
                          // TODO: Implement forget password logic
                        },
                        text: 'Reset Password',
                        btnColor: blueButton,
                      ),
                      const SpaceVH(height: 20.0),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const LoginPage()));
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Back to Login page ',
                              style: headline.copyWith(
                                fontSize: 14.0,
                              ),
                            ),
                            TextSpan(
                              text: ' Login',
                              style: headlineDot.copyWith(
                                fontSize: 14.0,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
