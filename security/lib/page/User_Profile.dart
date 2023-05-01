import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../core/colors.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newFieldKeyController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _newFieldValueController =
      TextEditingController();
  late User _user;
  late File _imageFile;
  final picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _firestore.collection('users').doc(_user.uid).get().then((snapshot) {
      setState(() {
        _nameController.text = snapshot.data()!['name'] ?? '';
        _emailController.text = snapshot.data()!['email'] ?? '';
        _phoneNumberController.text = snapshot.data()!['phone'] ?? '';
      });
    });
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage:
                    _imageFile != null ? FileImage(_imageFile) : null,
                child: GestureDetector(
                  onTap: _getImage,
                  child: _imageFile == null
                      ? const Icon(Icons.person, size: 60)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _uploadImage,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Update Profile Picture'),
              ),
              Text(
                'Name:',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Email:',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Phone Number:',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _updateUserInfo,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Update Info'),
              ),
              const SizedBox(height: 32),
              Text(
                'Add info about you',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _newFieldKeyController,
                decoration: const InputDecoration(
                  hintText: 'Enter new field',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _newFieldValueController,
                decoration: const InputDecoration(
                  hintText: 'Enter new value of this field ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _addNewField,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Add Field'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final ref = _storage.ref().child('users/${_user.uid}/profile.png');
      await ref.putFile(_imageFile);
      final url = await ref.getDownloadURL();
      await _user.updatePhotoURL(url);
      await _firestore.collection('users').doc(_user.uid).update({
        'photoUrl': url,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile picture: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserInfo() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _user.updateDisplayName(_nameController.text);
      await _user.updateEmail(_emailController.text);
      await _firestore.collection('users').doc(_user.uid).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneNumberController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User info updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating user info: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addNewField() async {
    final newFieldKey = _newFieldKeyController.text.trim();
    final newFieldValue = _newFieldValueController.text.trim();
    if (newFieldKey.isEmpty || newFieldValue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a key and value')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _firestore
          .collection('users')
          .doc(_user.uid)
          .update({newFieldKey: newFieldValue});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New field added successfully')),
      );
      _newFieldKeyController.clear();
      _newFieldValueController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding new field: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
