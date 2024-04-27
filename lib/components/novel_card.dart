import 'package:flutter/material.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/screens/novelinfoscreen.dart';

class NovelCard extends StatelessWidget {
  NovelCard({super.key, required this.novelDetail});
  TruyenDetail novelDetail;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //message scaffold
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NovelInfo(novelDetail: novelDetail,))
        );

        
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                novelDetail.cover ?? '',
                fit: BoxFit.cover,
              ),
            ),
          )),
          Center(
            child: Text(
              novelDetail.tenTruyen,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
