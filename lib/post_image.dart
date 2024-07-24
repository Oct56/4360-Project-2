import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class Post extends StatefulWidget {
  @override
    State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  
  TextEditingController writeDescription = TextEditingController();
  File? file;

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
  
  chooseCameraOrGallery(a) { //take image
    return showDialog(
      context: a,
      builder: (context) {
        return SimpleDialog(
          title: Text("New Post", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Use Camera", style: TextStyle(color: Colors.black,),),
              onPressed: cameraPicture,
            ),
            SimpleDialogOption(
              child: Text("Choose Picture From Camera Roll", style: TextStyle(color: Colors.black,),),
              onPressed: galleryPicture,
            ),
            SimpleDialogOption(
              child: Text("Close", style: TextStyle(color: Colors.black,),),
              onPressed:() => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
  showPost() { //display
    return Container(
      color: Colors.grey[300], 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add_a_photo_sharp, color: Colors.blue[900], size: 100,),
          Padding(
            padding:  EdgeInsets.only(top:10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),),),
              child: Text("Showcase Your Latest Artwork!", style: TextStyle(color: Colors.grey[300], fontSize: 20),),
              onPressed: () => chooseCameraOrGallery(context)
            ),
          ),
        ],
      ),
    );
  }

  remove() {   //takes away image
  setState(() {
    file = null;
  });
  }

  makeDescription() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(icon: Icon(Icons.arrow_back_outlined, color : Colors.blue[900],), 
        onPressed: remove),
        title: Text("New Artfolio Post", style: TextStyle(fontSize: 20, color: Colors.blue[900], fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
               height: 180,
               width: MediaQuery.of(context).size.width * 0.9,
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(5),
                 child: Image.file(file!, fit: BoxFit.cover,
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
              onPressed: () => print("it works"), //just put something to make the code work, i think this is where carson will have to edit to move to the feed.
              child: Text("Share Artwork", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 15),),)
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return file == null ? showPost() : makeDescription();
  }
}