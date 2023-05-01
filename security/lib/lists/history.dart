import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final CollectionReference _historyRef =
      FirebaseFirestore.instance.collection('login_history');

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // If there's no logged-in user, show a message
      return Scaffold(
        appBar: AppBar(
          title: Text('Login History'),
        ),
        body: Center(
          child: Text('You need to sign in to see your login history.'),
        ),
      );
    } else {
      // If there's a logged-in user, show the history
      return Scaffold(
        appBar: AppBar(
          title: Text('Login History'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _historyRef
              .where('userId', isEqualTo: currentUser.uid)
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final history = snapshot.data!.docs;
            if (history.isEmpty) {
              // If there's no login history, show a message
              return Center(
                child: Text('You have no login history yet.'),
              );
            } else {
              // If there's login history, show it in a ListView
              return ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final login = history[index].data() as Map<String, dynamic>;
                  final timestamp = login['timestamp'];
                  final userId = login['userId'];
                  return ListTile(
                    title: Text(timestamp.toString()),
                    subtitle: Text('User ID: $userId'),
                  );
                },
              );
            }
          },
        ),
      );
    }
  }
}
