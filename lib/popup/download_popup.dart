import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/service/api_service.dart';
import 'package:novel_crawl/service/file_service.dart';

class DownloadPopup extends StatefulWidget {
  const DownloadPopup({super.key, required this.novel});
  final TruyenDetail novel;
  

  @override
  State<DownloadPopup> createState() => _DownloadPopupState();
}

class _DownloadPopupState extends State<DownloadPopup> {
  bool _isLoading = false;
  final  _startChapterController = TextEditingController();
  final _endChapterController = TextEditingController();
  final APIService apiService = APIService();
  Future<void> downloadNovel() async {
    int startChapter = int.parse(_startChapterController.text);
    int endChapter = int.parse(_endChapterController.text);
    for(int i = startChapter; i <= endChapter; i++){
      await apiService.getChapterContent(widget.novel, i).then((value){
        FileService.instance.saveNovelImage(widget.novel.tenTruyen, widget.novel.cover);
        FileService.instance.addANovelDetail(widget.novel).then((_){
          FileService.instance.saveChapter(widget.novel.tenTruyen, '$i', value);
        });
      });
      
    }
    setLoading(false);
  }

  void setLoading(bool value){
    setState(() {
      _isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [AlertDialog(
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
              try{
                if(_startChapterController.text.isEmpty || _endChapterController.text.isEmpty){
                  return;
                }
                int startChapter = int.parse(_startChapterController.text);
                int endChapter = int.parse(_endChapterController.text);
                if(startChapter < 1 || endChapter > widget.novel.numberOfChapters){
                  _startChapterController.text = '1';
                  _endChapterController.text = min(widget.novel.numberOfChapters, 10).toString();
                  return;
                }
                if(startChapter > endChapter){
                  _endChapterController.text = startChapter.toString();
                  return;
                }
                if(endChapter - startChapter > 10){
                  _endChapterController.text = min(widget.novel.numberOfChapters, startChapter + 10).toString();
                  return;
                }
                downloadNovel();
                setLoading(true);
                
              } catch (e) {
                print(e);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Tải về', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      _isLoading ? Container(
        color: Colors.black.withOpacity(0.5), // Semi-transparent black color
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Container(),
      ]
    );
  }
}