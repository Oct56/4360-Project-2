import 'package:flutter/material.dart';

class Comment extends StatelessWidget{
  final String text;
  final String user;
  void Function()? onTap;
  Comment({super.key, required this.text, required this.user});
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        children: [
          Text(user),
          Text(text)
        ],
      ),
    );
  }
}