import 'package:flutter/material.dart';

class DescriptionView extends StatelessWidget {
  const DescriptionView({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Giới thiệu',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    );
  }
}