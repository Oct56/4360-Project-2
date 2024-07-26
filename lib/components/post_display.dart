import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group7_artfolio/components/comment.dart';
import 'package:group7_artfolio/components/comment_button.dart';
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

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postsRef =
        FirebaseFirestore.instance.collection('posts').doc(widget.postId);

    if (isLiked) {
      postsRef.update({
        'likes': FieldValue.arrayUnion([currentUser!.email])
      });
    } else {
      postsRef.update({
        'likes': FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }

  void addComment(String commentText) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .add({"commentText": commentText, "commentedBy": currentUser!.email});
  }

  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add Comment"),
              content: TextField(
                controller: commentController,
                decoration: InputDecoration(hintText: "Write a comment."),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      addComment(commentController.text);
                      commentController.clear();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Post",
                      style: TextStyle(color: Colors.grey),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      commentController.clear();
                    },
                    child: Text("Cancel", style: TextStyle(color: Colors.grey)))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        /*decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 25),
      padding: EdgeInsets.all(25),*/
        child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LikeButton(
                  isLiked: isLiked,
                  onTap: toggleLike,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.likes.length.toString(),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            Column(
              children: [
                CommentButton(onTap: showCommentDialog),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
            child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.postId)
                  .collection('comments')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    final commentData = doc.data() as Map<String, dynamic>;
                    return Comment(
                        text: commentData['commentText'],
                        user: commentData['commentedBy']);
                  }).toList(),
                );
              },
            ),
          ],
        ))
      ],
    ));
  }
}
