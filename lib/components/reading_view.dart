import 'package:flutter/material.dart';

class ReadingView extends StatelessWidget {
  const ReadingView({super.key, required this.content, required this.fontSize, required this.fontFamily, required this.color, required this.spacing});
  final String content;
  final double fontSize;
  final String fontFamily;
  final int color;
  final int spacing;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content,
            style: TextStyle(
              fontSize: fontSize.toDouble(),
              color: Colors.white,
              height: spacing.toDouble()
            ),
        ),
        ),
      )
    );
  }
}