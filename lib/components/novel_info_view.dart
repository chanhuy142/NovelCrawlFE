import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:novel_crawl/models/novel_detail.dart';

class NovelInfoView extends StatelessWidget {
  NovelInfoView({super.key, required this.novelDetail});
  TruyenDetail novelDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF444444),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            width: 150,
            padding: EdgeInsets.all(20),
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
                  novelDetail.tenTruyen,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Text(
                  'bởi ' + novelDetail.author,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                ),
                Text(
                  novelDetail.numberOfChapters.toString() + ' chương',
                  style: TextStyle(color: Colors.white)
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