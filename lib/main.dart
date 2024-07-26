import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group7_artfolio/screens/login.dart';
import 'package:group7_artfolio/screens/profile.dart';
import 'package:group7_artfolio/screens/post_image.dart';
import 'package:group7_artfolio/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:group7_artfolio/components/post_display.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      theme: myTheme,
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage();
          }
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key) {
    stream = postsReference.snapshots();
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

  int _selectedIndex = 0; // navigation bar icon page index

  Future<void> _sendEmail(String? userEmail) async {
    if (userEmail == null) {
      // Handle the case where userId is null
      print('User ID is null, cannot send email.');
      return;
    }

    //String? email = await getEmailOfPoster(userId);

if (userEmail != null) {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: userEmail,
         query: _encodeQueryParameters(<String, String>{
        'subject': 'I saw your art on Artfolio...',
        'body': 'I would like to bid'
      }),
      );
      launchUrl(emailLaunchUri);
    }
  }

  String _encodeQueryParameters(Map<String, String> params) {
  return params.entries.map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
}

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      //home
      case 0:
        break;
      //profile
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Post()),
        );
        break;
    }
  }

  CollectionReference postsReference =
      FirebaseFirestore.instance.collection('posts');
  late Stream<QuerySnapshot> stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
        centerTitle: true, // Center the title
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOut(context),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('An error has occurred'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            List<Map> items = documents.map((e) => e.data() as Map).toList();
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Map thisItem = items[index];
                String? username = thisItem['username'];
                String? caption = thisItem['caption'];
                String? imageURL = thisItem['imageURL'];
                String? userEmail = thisItem[
                    'userEmail']; // Ensure this is being retrieved correctly

                if (username == null) {
                  return ListTile(
                    title: Text('Missing User Info'),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (imageURL != null)
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: double.infinity,
                            child: Image.network(imageURL, fit: BoxFit.cover),
                          ),
                        ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.mail_outline,
                              size: 20,
                            ),
                            onPressed: () {
                              _sendEmail(
                                  userEmail); // Ensure userId is not null
                            },
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(caption ?? 'No caption'),
                      PostDisplay(
                            caption: thisItem['caption'],
                            user: thisItem['username'],
                            imageURL: thisItem['imageURL'],
                            likes: List<String>.from(thisItem['likes'] ?? []),
                            postId: thisItem['id'],
                          ),
                      Divider(),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No posts available'));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index, context),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          // add more sections to nav bar here
        ],
      ),
    );
  }
}
