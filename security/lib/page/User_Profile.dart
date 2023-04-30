import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:security/core/text_style.dart';
import '../../core/colors.dart';
import '../../core/space.dart';
import '../../widget/main_button.dart';
import '../../widget/text_fild.dart';
import 'spalsh_Page/onboding_screen.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPh = TextEditingController();
  bool _isScure = true;
  bool _isEnabled = false;
  bool _isEditing = false;
  PickedFile? _imageFile;

  final List<String> options = ['Driver', 'Customer', 'Owner'];
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String? email;
  String? password;
  String? Name;
  String? phone;
  String? selectedOption;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void _openImagePicker() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void fetchUserData() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    if (userData.exists) {
      setState(() {
        userName.text = userData.data()?['name'];
        userEmail.text = userData.data()?['email'];
        userPh.text = userData.data()?['phone'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColorDark,
        title: const Text("User Info",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: whiteText,
            )),
      ),
      backgroundColor: blackBG,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //head of page
                const SpaceVH(height: 50.0),
                //text hint
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    final userData =
                        snapshot.data?.data() as Map<String, dynamic>?;
                    final userName = userData?['name'] as String?;
                    return Text(
                      'Welcome ${userName ?? 'Driver'}!',
                      style: hintStyle,
                    );
                  },
                ),

                const SpaceVH(height: 10.0),
                InkWell(
                  onTap: () => _openImagePicker(),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _imageFile == null
                            ? null
                            : FileImage(File(_imageFile!.path)),
                        child: _imageFile == null
                            ? const Icon(
                                Icons.person,
                                size: 50,
                              )
                            : null,
                      ),
                      if (_imageFile == null)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                    ],
                  ),
                ),

                //userName
                const SpaceVH(height: 30.0),
                textField(
                  onChanged: (data) {
                    Name = data;
                  },
                  controller: userName,
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  keyboardType: TextInputType.name,
                  hintTxt: 'Full Name',
                  enabled: _isEnabled,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                //userEmail
                textField(
                  enabled: false,
                  controller: userEmail,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  hintTxt: 'Email Address',
                ),
                //user Number
                textField(
                  onChanged: (data) {
                    phone = data;
                  },
                  controller: userPh,
                  prefixIcon: const Icon(Icons.phone),
                  keyboardType: TextInputType.phone,
                  hintTxt: 'Phone Number',
                  enabled: _isEnabled,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),

                // Edit button
                const SpaceVH(height: 20.0),
                TextButton(
                  // Edit button onPressed callback
                  onPressed: () {
                    if (_isEditing) {
                      // Save the changes to Firestore and lock the text fields
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        userName.text = Name!;
                        userPh.text = phone!;
                        userEmail.text = email!;

                        selectedOption = options[0];
                        users.doc(user!.uid).update({
                          'name': Name,
                          'email': email,
                          'phone': phone,
                        });
                        userEmail.clear();
                        userPh.clear();
                        userPass.clear();
                        formKey.currentState!.reset();
                        _isScure = true;
                        _isEditing = false;
                        _isEnabled = false;
                      }
                    } else {
                      // Allow the user to edit the text fields
                      _isEditing = true;
                      _isEnabled = true;
                    }
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Edit Your acount information: ',
                        style: headline.copyWith(
                          fontSize: 14.0,
                        ),
                      ),
                      TextSpan(
                        text: 'edit',
                        style: headlineDot.copyWith(
                          fontSize: 14.0,
                          color: redColor,
                        ),
                      ),
                    ]),
                  ),
                ),

                //Logout button
                SpaceVH(height: 50.0),
                Mainbutton(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnboardingScreen()),
                    );
                  },
                  text: 'Logout',
                  btnColor: blueButton,
                ),

                //switch to Login
                const SpaceVH(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
