import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group7_artfolio/components/like_button.dart';

class PostDisplay extends StatefulWidget {
  final String caption;
  final String user;
  final String imageURL;
  final String postId;
  final List<String> likes;
  PostDisplay(
      {super.key,
      required this.caption,
      required this.user,
      required this.imageURL,
      required this.likes,
      required this.postId});

  @override
  State<PostDisplay> createState() => _PostDisplayState();
}

class _PostDisplayState extends State<PostDisplay> {
  final currentUser = FirebaseAuth.instance.currentUser;

  bool isLiked = false;

  final commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser!.email);
  }

  void toggleLike(){
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postsRef = FirebaseFirestore.instance.collection('posts').doc(widget.postId);

    if(isLiked){
      postsRef.update({
        'likes': FieldValue.arrayUnion([currentUser!.email])
      });
    }else{
      postsRef.update({
        'likes': FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }

  void addComment(String commentText){
    FirebaseFirestore.instance.collection('posts').doc(widget.postId).collection('comments').add({
      "commentText": commentText,
      "commentedBy": widget.user
    });
  }
  void showCommentDialog(){
    showDialog(context: context, 
    builder: (context) => AlertDialog(
      title: Text("Add Comment"),
      content: TextField(
        controller: commentController,
        decoration: InputDecoration(hintText: "Write a comment."),
      ),
      actions: [
        TextButton(onPressed: () => addComment(commentController.text), child: Text("Post")),
        TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel"))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 25),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Column(

            children: [
              LikeButton(
                isLiked: isLiked, 
                onTap: toggleLike,
                ),
                const SizedBox(height: 5,),
                Text(
                  widget.likes.length.toString(),
                  style: TextStyle(color: Colors.grey),)
                ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.user),
              Row(children: [
                SizedBox(width: 5,),
                Text(widget.caption,
                //style: TextStyle(fontSize: 30),
                softWrap: true,
                maxLines: 5,),
              ],),
              Container(
                height: 200,
                width: 200,
                child: Image.network(widget.imageURL),
              ),
            ],
          )
        ],
      ),
    );
  }
}
