import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? username;
  String? bio;

  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async { //retrieves user data from firebase with the userId assigned with each unique email
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(currentUser.uid).get();
      if (snapshot.exists) {
        setState(() { //if anything else needs to be added to firebase through the user profile, copy the format below (a snapshot and a controller)
          username = snapshot.get('username');
          bio = snapshot.get('bio');
          usernameController.text = username ?? '';
          bioController.text = bio ?? '';
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> saveUserData() async {
    try {
      await _firestore.collection('users').doc(currentUser.uid).set({
        'username': usernameController.text.trim(),
        'bio': bioController.text.trim(),
      }, SetOptions(merge: true));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully'),
        ),
      );
    } catch (e) {
      print('Error saving user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveUserData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              currentUser.email!,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Username:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Enter your username',
              ),
              onChanged: (value) => username = value,
            ),
            SizedBox(height: 20),
            Text(
              'Bio:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: bioController,
              decoration: InputDecoration(
                hintText: 'Enter your bio',
              ),
              onChanged: (value) => bio = value,
            ),
          ],
        ),
      ),
    );
  }
}
