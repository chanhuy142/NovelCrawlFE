import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:novel_crawl/models/novel_detail.dart';

class DownloadPopup extends StatefulWidget {
  const DownloadPopup({super.key, required this.novel});
  final TruyenDetail novel;
  

  @override
  State<DownloadPopup> createState() => _DownloadPopupState();
}

class _DownloadPopupState extends State<DownloadPopup> {
  final  _startChapterController = TextEditingController();
  final _endChapterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: Center(child: Text('Tải truyện', style: TextStyle(color: Colors.white),)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _startChapterController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Từ chương',
              hintStyle: TextStyle(color: Colors.white)
            ),
          ),
          TextField(
            controller: _endChapterController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Đến chương',
              hintStyle: TextStyle(color: Colors.white)
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Hủy', style: TextStyle(color: Colors.white),),
        ),
        TextButton(
          onPressed: () {
            //download novel
          },
          child: Text('Tải về', style: TextStyle(color: Colors.white),),
        )
      ],
    );
  }
}