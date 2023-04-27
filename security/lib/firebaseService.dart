import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:security/page/started_pages/Customer/Custom_start.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseService {
  // Initialize Firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore get db => _firestore;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  // Authentication
  static Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle any authentication errors
      print('Error: ${e.code} - ${e.message}');
      return null;
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user has previously signed in
      final User? user = userCredential.user;
      final DocumentSnapshot? docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (docSnapshot!.exists) {
        // Create a new user document in Firestore if the user is new
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
        });
      }

      // Navigate to the next page if the email is new to the completedEmails collection
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CustomerStartPage()),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<UserCredential?> signInWithApple() async {
    // 1. Request the user's Apple ID credentials.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // 2. Create an `OAuthCredential` from the Apple ID credential.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // 3. Sign in to Firebase with the `OAuthCredential`.
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return userCredential;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Firestore
  static Future<DocumentSnapshot?> getDocument(
      String collection, String docId) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .get();
      return docSnapshot;
    } catch (e) {
      // Handle any Firestore errors
      print('Error: $e');
      return null;
    }
  }

  static Future<QuerySnapshot?> getDocuments(String collection) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collection).get();
      return querySnapshot;
    } catch (e) {
      // Handle any Firestore errors
      print('Error: $e');
      return null;
    }
  }

  static Future<DocumentReference?> addDocument(
      String collection, Map<String, dynamic> data) async {
    try {
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection(collection).add(data);
      return docRef;
    } catch (e) {
      // Handle any Firestore errors
      print('Error: $e');
      return null;
    }
  }

  static Future<void> updateDocument(
      String collection, String docId, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .update(data);
    } catch (e) {
      // Handle any Firestore errors
      print('Error: $e');
    }
  }

  static Future<void> deleteDocument(String collection, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .delete();
    } catch (e) {
      // Handle any Firestore errors
      print('Error: $e');
    }
  }
}
