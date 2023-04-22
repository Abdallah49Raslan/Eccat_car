import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:security/core/space.dart';
import 'package:security/page/Authintication/Forget_Pass.dart';
import 'package:security/page/Authintication/sign_up.dart';
import '../../controler/LogInLogic.dart';
import '../../core/colors.dart';
import '../../core/text_style.dart';
import '../../widget/main_button.dart';
import '../../widget/text_fild.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, String? errorMessage}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();
  bool _isScure = true;
  bool rememberMe = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    _getEmailAndPassword();
  }

  void _getEmailAndPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('rememberMe') ?? false;
    if (rememberMe) {
      setState(() {
        _email = prefs.getString('email') ?? '';
        _password = prefs.getString('password') ?? '';
        userEmail.text = _email;
        userPass.text = _password;
      });
    }
  }

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
                //logo image
                Container(
                  alignment: Alignment.center,
                  height: 150,
                  child: Image.asset(
                    'assets/image/logo.png',
                    width: 150,
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
                const SpaceVH(height: 20.0),
                textField(
                  onChanged: (data) {
                    _email = data;
                  },
                  controller: userEmail,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  hintTxt: 'Email Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email';
                    }
                    return null;
                  },
                ),

                //Password
                textField(
                  onChanged: (data) {
                    _password = data;
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Password';
                    }
                    return null;
                  },
                ),

                //forgetPass
                const SpaceVH(height: 10.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const ForgetPassword()));
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: headline3,
                      ),
                    ),
                  ),
                ),

                //LogIn Button
                const SpaceVH(height: 20.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      CheckboxListTile(
                        value: rememberMe,
                        onChanged: (value) async {
                          setState(() {
                            rememberMe = value!;
                          });
                          if (rememberMe) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('email', _email);
                            prefs.setString('password', _password);
                          } else {
                            // If "Remember me" is not checked, clear the saved email and password
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('email');
                            prefs.remove('password');
                          }
                        },
                        title: const Text(
                          'Remember me',
                          style: headline2,
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),

                      Mainbutton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            if (rememberMe) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('email', _email);
                              prefs.setString('password', _password);
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginLogic(
                                  email: _email,
                                  password: _password,
                                ),
                              ),
                            );
                          }
                        },
                        text: 'Sign in',
                        btnColor: blueButton,
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
