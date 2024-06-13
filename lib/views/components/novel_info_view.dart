import 'package:flutter/material.dart';
import 'package:novel_crawl/models/novel.dart';

class NovelInfoView extends StatelessWidget {
  NovelInfoView({super.key, required this.novelDetail});
  final Novel novelDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF444444),
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            width: 150,
            padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  novelDetail.cover ?? '',
                  fit: BoxFit.fitWidth,
                ),
              ),        ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  novelDetail.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Text(
                  'bởi ${novelDetail.author}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                ),
                Text(
                  '${novelDetail.numberOfChapters} chương',
                  style: const TextStyle(color: Colors.white)
                )
                // Text(
                //   novelDetail.theLoai,
                //   style: TextStyle(color: Colors.white),
                // ),
                // Text(
                //   novelDetail.moTa,
                //   style: TextStyle(color: Colors.white),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}