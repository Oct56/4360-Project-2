import 'package:flutter/material.dart';

//unused for now, but may re-implement bc it looks nicer that what i have now LOL

class MyTextBox extends StatelessWidget {
  final String text;
  final String section;
  final void Function()? onPressed;
  final void Function(String)? onChanged;

  const MyTextBox({
    Key? key,
    required this.text,
    required this.section,
    required this.onPressed,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                section,
                style: TextStyle(color: Colors.grey),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter $section',
            ),
            controller: TextEditingController(text: text),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
