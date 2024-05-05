import 'package:flutter/material.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/screens/readingscreen.dart';

class ChapterListView extends StatefulWidget {
  ChapterListView({super.key, required this.chapterNumber, required this.novel});
  int chapterNumber;
  TruyenDetail novel;


  @override
  State<ChapterListView> createState() => _ChapterListViewState();
}


class _ChapterListViewState extends State<ChapterListView> {
  late int chapterNumber;
  int currentPage = 1;
  int totalPages = 1;
  int numberChapterPerPage = 20;

  @override
  void initState() {
    super.initState();
    chapterNumber = widget.chapterNumber;
    totalPages = (chapterNumber / numberChapterPerPage).ceil();
  }
  


  @override
  Widget build(BuildContext context) {
    print('ChapterListView build');
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
       [const Text(
        'Danh sách chương',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.yellowAccent,
        ),
       ),
       Container(
        margin: const EdgeInsets.only(top: 5.0),
        height: 2.0,
        color: Colors.yellowAccent,
      ),
        
        Expanded(
          child: ListView.builder(
            itemCount: currentPage == totalPages ? chapterNumber%numberChapterPerPage : numberChapterPerPage,
            itemBuilder: (context, index) {
              var chapter = index + 1 + numberChapterPerPage*(currentPage-1);
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReadingScreen(novel: widget.novel, chapter: chapter)));
                },
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    child:  Text(
                      'Chương $chapter',
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),  
                    )
                ),
              );
            },
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  if (currentPage > 1) {
                    currentPage -= 1;
                  }
                });
              },
            ),
            Text(
              '$currentPage/$totalPages', 
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              )),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                setState(() {
                  if (currentPage < totalPages) {
                    currentPage += 1;
                  }
                });
              },
            ),
          ],
        ),
      ],
    )
    );
  }
}