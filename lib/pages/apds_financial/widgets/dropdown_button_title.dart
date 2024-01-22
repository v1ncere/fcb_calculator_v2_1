import 'package:flutter/material.dart';

class DropdownButtonTitle extends StatelessWidget {
  const DropdownButtonTitle({
    super.key, 
    required this.title
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.lightGreen[700])
      )
    );
  }
}