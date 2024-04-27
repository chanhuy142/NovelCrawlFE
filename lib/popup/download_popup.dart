import 'package:flutter/material.dart';
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
      title: const Center(child: Text('Tải truyện', style: TextStyle(color: Colors.white),)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _startChapterController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Từ chương',
              hintStyle: TextStyle(color: Colors.white)
            ),
          ),
          TextField(
            controller: _endChapterController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
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
          child: const Text('Hủy', style: TextStyle(color: Colors.white),),
        ),
        TextButton(
          onPressed: () {
            //download novel
          },
          child: const Text('Tải về', style: TextStyle(color: Colors.white),),
        )
      ],
    );
  }
}