import 'package:flutter/material.dart';
import 'package:novel_crawl/components/novel_source_selector.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/popup/download_popup.dart';
import 'package:novel_crawl/screens/settingscreen.dart';

class ReadingModalBottom extends StatefulWidget {
  const ReadingModalBottom({super.key, required this.currentChapter, required this.novel, required this.onChapterChanged, required this.sources, required this.onUpdated});
  final int currentChapter;
  final TruyenDetail novel;
  final ValueChanged<int> onChapterChanged;
  final List<String> sources;
  final Function() onUpdated;
  @override
  State<ReadingModalBottom> createState() => _ReadingModalBottomState();
}

class _ReadingModalBottomState extends State<ReadingModalBottom> {
  int currentChapter = 1;
  int totalChapter = 1;

  @override
  void initState() {
    super.initState();
    currentChapter = widget.currentChapter;
    totalChapter = widget.novel.numberOfChapters;
  }

  void showDownloadDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DownloadPopup(novel: widget.novel,);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          GestureDetector(
            onTap: () {
              //download novel
              showDownloadDialog();
            },
            child: Container(
              color: Colors.transparent,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Icon(Icons.download, color: Colors.white,),
                Text('Tải về', style: TextStyle(color: Colors.white),)
              ],),
            )
          ),
           Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  if (currentChapter > 1) {
                    currentChapter -= 1;
                    widget.onChapterChanged(currentChapter);
                  }
                });
              },
            ),
            Text(
              '$currentChapter/$totalChapter', 
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              )),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                setState(() {
                  if (currentChapter < totalChapter) {
                    currentChapter += 1;
                    widget.onChapterChanged(currentChapter);
                  }
                });
              },
            ),
          ],
        ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                    builder: (BuildContext context) {
                      return Container(
                          height: 700,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          child: SettingPage(
                              novelSourceSelector: NovelSourceSelector(
                                  novelSources: widget.sources,
                                  onUpdated: widget.onUpdated)));
                    }
              );
            },
            child: Container(
              color: Colors.transparent,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Icon(Icons.settings, color: Colors.white,),
                Text('Cài đặt', style: TextStyle(color: Colors.white),)
              ],),
            )
          ),
        ],),
    );
  }
}