import 'package:flutter/material.dart';
import 'package:novel_crawl/models/novel_detail.dart';

class DescriptionView extends StatelessWidget {
  const DescriptionView({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              description,
              style: const TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'Montserrat'),
            )
          ],
        ),
      ),
    );
  }
}