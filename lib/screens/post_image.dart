import 'dart:ffi';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:group7_artfolio/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group7_artfolio/post.dart';
import 'package:group7_artfolio/screens/profile.dart';

class Post extends StatefulWidget {
  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final CollectionReference databaseRef2 = FirebaseFirestore.instance.collection('users');
  final CollectionReference databaseRef = FirebaseFirestore.instance.collection('posts');
  final currentUser = FirebaseAuth.instance.currentUser!;
  TextEditingController writeDescription = TextEditingController();
  File? file;
  String imageURL = '';

  galleryPicture() async {
    Navigator.pop(context);
    final picFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (picFile != null) {
      setState(() {
        file = File(picFile.path);
      });
    }
  }

  cameraPicture() async {
    Navigator.pop(context);
    final picFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1080,
      maxHeight: 1080,
    );

    if (picFile != null) {
      setState(() {
        file = File(picFile.path);
      });
    }
  }

  chooseCameraOrGallery(a) {
    return showDialog(
      context: a,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "New Post",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          children: <Widget>[
            SimpleDialogOption(
              child: Text(
                "Use Camera",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: cameraPicture,
            ),
            SimpleDialogOption(
              child: Text(
                "Choose Picture From Camera Roll",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: galleryPicture,
            ),
            SimpleDialogOption(
              child: Text(
                "Close",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  showPost() {
    return Container(
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.add_a_photo_sharp,
            color: Colors.blue[900],
            size: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Showcase Your Latest Artwork!",
                style: TextStyle(color: Colors.grey[300], fontSize: 20),
              ),
              onPressed: () => chooseCameraOrGallery(context),
            ),
          ),
        ],
      ),
    );
  }

  remove() {
    setState(() {
      file = null;
    });
  }

  makeDescription() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.blue[900],
          ),
          onPressed: remove,
        ),
        title: Text(
          "New Artfolio Post",
          style: TextStyle(
              fontSize: 20,
              color: Colors.blue[900],
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.file(
                  file!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: Container(
                width: 250,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: writeDescription,
                  decoration: InputDecoration(
                    hintText: "Start writing your caption here...",
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () => create_post(),
              child: Text(
                "Share Artwork",
                style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> create_post() async {
  if (file == null) return;

  Reference referenceRoot = FirebaseStorage.instance.ref();
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  Reference referenceDirImages = referenceRoot.child('images');
  Reference referenceToUpload = referenceDirImages.child(fileName);

  // Upload the file and wait until it's done
  UploadTask uploadTask = referenceToUpload.putFile(File(file!.path));

  // Wait for the upload task to complete
  TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

  // Get the download URL
  String imageURL = await snapshot.ref.getDownloadURL();
  DocumentSnapshot snapshot2 = await databaseRef2.doc(currentUser.uid).get();
  var value;
  if (snapshot2.exists) {
    Map<String, dynamic>? data = snapshot2.data() as Map<String, dynamic>?;
    value = data?['username'];
    setState(() {});
  }

  final post = NewPost(
    id: databaseRef.doc().id,
    userId: currentUser.uid, // Ensure userId is added here
    username: value,
    caption: writeDescription.text,
    imageURL: imageURL,
  );

  await databaseRef.doc(post.id).set(post.toMap());
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
}

  @override
  Widget build(BuildContext context) {
    return file == null ? showPost() : makeDescription();
  }
}
