// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:security/controler/LogInLogic.dart';
// import 'package:security/core/colors.dart';

// import '../../widget/Dropdown_Menu.dart';
// import '../../widget/main_button.dart';
// import '../../widget/text_fild.dart';

// class UserRoleSelectionPage extends StatefulWidget {
//   @override
//   _UserRoleSelectionPageState createState() => _UserRoleSelectionPageState();
// }

// class _UserRoleSelectionPageState extends State<UserRoleSelectionPage> {
//   String? selectedOption;
//   String? userID;
//   String? driverLic;
  

//   final personId = TextEditingController();
//   final driverLicense = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Role Selection'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Please select your role:',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10.0),
//             DropdownButtonFormField(
//               value: selectedOption,
//               items: ['Customer', 'Driver', 'Manager']
//                   .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                   .toList(),
//               onChanged: (newValue) {
//                 setState(() {
//                   selectedOption = newValue.toString();
//                 });
//               },
//             ),
//             if (selectedOption == 'Driver')
//               Column(
//                 children: [
//                   SizedBox(height: 20.0),
//                   TextField(
//                     onChanged: (data) {
//                       userID = data;
//                     },
//                     controller: personId,
//                     decoration: InputDecoration(
//                       hintText: 'Driver ID',
//                       prefixIcon: Icon(Icons.credit_card_sharp),
//                     ),
//                   ),
//                   SizedBox(height: 20.0),
//                   TextField(
//                     onChanged: (data) {
//                       driverLic = data;
//                     },
//                     controller: driverLicense,
//                     decoration: InputDecoration(
//                       hintText: 'Driver License Number',
//                       prefixIcon: Icon(Icons.credit_card),
//                     ),
//                   ),
//                 ],
//               ),
//             SizedBox(height: 20.0),
//             Mainbutton(
//               onTap: () { signInWithGoogle(context); },
        
          
//               btnColor: blueButton,
              
//               text: 'Continue',
              
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   static Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser!.authentication;
//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       final UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithCredential(
//               credential); // Check if the user has previously signed in
//       final User? user = userCredential.user;
//       final DocumentSnapshot? docSnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user!.uid)
//           .get();

//       if (!docSnapshot!.exists) {
//         // Create a new user document in Firestore if the user is new
//         await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//           'name': user.displayName,
//           'email': user.email,
//           'photoUrl': user.photoURL,
//           'role': user, // Add user role to Firestore document
//         });
//       }

//       // Check if the user has already navigated to the next page before
//       final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('completedEmails')
//           .where('email', isEqualTo: user.email)
//           .get();

//       if (querySnapshot.docs.isEmpty) {
//         // Add the user's email to the completedEmails collection if it hasn't been added before
//         await FirebaseFirestore.instance
//             .collection('completedEmails')
//             .add({'email': user.email});

//         // Navigate to the next page if the email is new to the completedEmails collection
//         // ignore: use_build_context_synchronously
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => LoginLogic()),
//         );
//       }
//     }
//   }
// }
