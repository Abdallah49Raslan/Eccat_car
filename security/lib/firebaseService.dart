import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  // Firestore
  static Future<DocumentSnapshot?> getDocument(String collection, String docId) async {
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
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collection)
          .get();
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
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection(collection)
          .add(data);
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
