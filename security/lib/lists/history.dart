import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Stream<QuerySnapshot> _loginStream;
  late Stream<QuerySnapshot> _signupStream;

  @override
  void initState() {
    super.initState();
    // Get a stream of login events for the current user
    _loginStream = _db
        .collection('logins')
        .where('userId', isEqualTo: _auth.currentUser!.uid)
        .orderBy('timestamp', descending: true)
        .snapshots();

    // Get a stream of signup events for the current user
    _signupStream = _db
        .collection('signups')
        .where('userId', isEqualTo: _auth.currentUser!.uid)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Logins'),
              Tab(text: 'Signups'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLoginHistory(),
            _buildSignupHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginHistory() {
    return StreamBuilder<QuerySnapshot>(
      stream: _loginStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No login events found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            final loginData =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            final timestamp = loginData['timestamp'] as Timestamp;
            final date = timestamp.toDate().toString();
            return ListTile(
              leading: const Icon(Icons.login),
              title: Text('Logged in at $date'),
            );
          },
        );
      },
    );
  }

  Widget _buildSignupHistory() {
    return StreamBuilder<QuerySnapshot>(
      stream: _signupStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No signup events found'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            final signupData =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            final timestamp = signupData['timestamp'] as Timestamp;
            final date = timestamp.toDate();
            final email = signupData['email'] as String;
            final name = signupData['name'] as String;
            final role = signupData['user'] as String;
            return ListTile(
              leading: const Icon(Icons.history),
              title: Text(
                  'User $name ($email) signed up as a $role on ${DateFormat.yMMMMd().add_jm().format(date)}'),
            );
          },
        );
      },
    );
  }
}
