import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controler/SignUpLogic.dart';
import '../core/colors.dart';
import '../core/space.dart';
import '../core/text_style.dart';
import '../widget/main_button.dart';
import '../widget/text_fild.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPh = TextEditingController();
  bool _isScure = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String? email;
  String? password;
  String? Name;
  String? phone;

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
                //head of page
                const SpaceVH(height: 50.0),
                const Text(
                  'Create new account',
                  style: headline1,
                ),

                //text hint
                const SpaceVH(height: 10.0),
                const Text(
                  'Please fill in the form to continue',
                  style: headline3,
                ),

                //userName
                const SpaceVH(height: 60.0),
                textField(
                  onChanged: (data) {
                    Name = data;
                  },
                  controller: userName,
                  prefixIcon: Icon(Icons.person_outline_rounded),
                  keyboardType: TextInputType.name,
                  hintTxt: 'Full Name',
                ),

                //userEmail
                textField(
                  onChanged: (data) {
                    email = data;
                  },
                  controller: userEmail,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                  hintTxt: 'Email Address',
                ),

                //user Number
                textField(
                  onChanged: (data) {
                    phone = data;
                  },
                  controller: userPh,
                  prefixIcon: Icon(Icons.phone),
                  keyboardType: TextInputType.phone,
                  hintTxt: 'Phone Number',
                ),

                //user Password
                textField(
                  onChanged: (data) {
                    password = data;
                  },
                  controller: userPass,
                  isObs: _isScure,
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
                  keyboardType: TextInputType.visiblePassword,
                  hintTxt: 'Password',
                ),
                //signUp Button
                const SpaceVH(height: 80.0),
                Mainbutton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpLogic(
                            email: email!,
                            password: password!,
                            name: Name!,
                            phone: phone!,
                          ),
                        ),
                      );

                    } else {
                      // handle case when form is not valid
                    }
                  },
                  text: 'Sign Up',
                  btnColor: blueButton,
                ),
                //switch to Login
                const SpaceVH(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Have an account? ',
                        style: headline.copyWith(
                          fontSize: 14.0,
                        ),
                      ),
                      TextSpan(
                        text: ' Sign In',
                        style: headlineDot.copyWith(
                          fontSize: 14.0,
                        ),
                      ),
                    ]),
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
