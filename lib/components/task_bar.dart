import 'package:flutter/material.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/popup/download_popup.dart';
import 'package:novel_crawl/screens/readingscreen.dart';
import 'package:novel_crawl/service/file_service.dart';
import 'package:novel_crawl/service/history_service.dart';

class TaskBar extends StatefulWidget {
  const TaskBar({super.key, required this.novel});
  final TruyenDetail novel;

  @override
  State<TaskBar> createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {

  TruyenDetail get novel => widget.novel;
  int currentChapter = 1;
  
  //3 button, 1 button icon 'Xuất Ebook', 1 textbutton màu vàng 'Đọc truyện', 1 button icon 'Tải về'
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void updateCurrentChapter(int chapter){
    setState(() {
      currentChapter = chapter;
    });
  }

  void readNovel(BuildContext context) {
    HistoryService.instance.getCurrentChapter(novel.tenTruyen).then((value){
      setState(() {
        currentChapter = value;
        Navigator.push(context, MaterialPageRoute(builder: (context) => ReadingScreen(novel: novel, chapter: currentChapter)));
      });
    });
  }


  void showDownloadDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DownloadPopup(novel: novel,);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          GestureDetector(
            onTap: () {
              //export novel
            },
            child: Container(
              color: Colors.transparent,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Icon(Icons.book, color: Colors.white,),
                Text('Ebook', style: TextStyle(color: Colors.white),)
              ],),
            )
          ),
          GestureDetector(
              onTap: () {
                readNovel(context);
              },
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                    //color: DFD82C
                    color: const Color(0xFFDFD82C),
                    borderRadius: BorderRadius.circular(15)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.import_contacts,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text("Đọc truyện",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))
                  ],
                ),
              ),
            ),
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
        ],),
    );
  }

  
}