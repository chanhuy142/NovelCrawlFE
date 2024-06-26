import 'package:flutter/material.dart';
import 'package:novel_crawl/controllers/reading_controller.dart';
import 'package:novel_crawl/models/novel.dart';
import 'package:novel_crawl/models/reading_model.dart';
import 'package:novel_crawl/views/screens/readingscreen.dart';
import 'package:novel_crawl/controllers/service/history_service.dart';

import '../../controllers/service/file_service.dart';

class ChapterListView extends StatefulWidget {
  ChapterListView(
      {super.key,
      required this.chapterNumber,
      required this.novel,
      required this.isOffline});
  final int chapterNumber;
  final Novel novel;
  final bool isOffline;

  @override
  State<ChapterListView> createState() => _ChapterListViewState();
}

class _ChapterListViewState extends State<ChapterListView> {
  late int chapterNumber;
  int currentPage = 1;
  int totalPages = 1;
  int numberChapterPerPage = 20;
  List<String> chapterList = [];
  HistoryService historyService = HistoryService.instance;
  Set<int> readChapter = {};

  @override
  void initState() {
    super.initState();
    chapterNumber = widget.chapterNumber;
    totalPages = (chapterNumber / numberChapterPerPage).ceil();
    if (widget.isOffline) {
      FileService.instance.getChapterList(widget.novel.name).then((value) {
        setState(() {
          chapterNumber = value.length;
          totalPages = (chapterNumber / numberChapterPerPage).ceil();
          chapterList = value;
        });
      });
    }

    loadReadChapter();
  }

  void loadReadChapter() {
    historyService.getReadChapters(widget.novel.name).then((value) {
      if (readChapter.length != value.length) {
        setState(() {
          readChapter = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        margin: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: widget.isOffline == false
                  ? ListView.builder(
                      itemCount: currentPage == totalPages
                          ? chapterNumber % numberChapterPerPage
                          : numberChapterPerPage,
                      itemBuilder: (context, index) {
                        var chapter = index +
                            1 +
                            numberChapterPerPage * (currentPage - 1);

                        bool isRead = readChapter.contains(chapter);

                        return GestureDetector(
                            onTap: () {
                              //readChapter.add(chapter);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReadingScreen(
                                          updateReadingChapters:
                                              loadReadChapter,
                                          readingController: ReadingController(
                                              readingModel: ReadingModel(
                                            novel: widget.novel,
                                            chapter: chapter,
                                            isOffline: widget.isOffline,
                                          ))))).then((_) {
                                // This block runs when you come back to the current screen
                                setState(() {
                                  // Update your state here
                                });
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Chương $chapter',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color:
                                        isRead ? Colors.white38 : Colors.white,
                                  ),
                                )));
                      },
                    )
                  : ListView.builder(
                      itemCount: currentPage == totalPages
                          ? chapterNumber % numberChapterPerPage
                          : numberChapterPerPage,
                      itemBuilder: (context, index) {
                        var chapter = '1';

                        if (chapterList.isNotEmpty) {
                          chapter = chapterList[
                              index + numberChapterPerPage * (currentPage - 1)];
                        }

                        bool isRead = readChapter.contains(int.parse(chapter));

                        return GestureDetector(
                            onTap: () {
                              readChapter.add(int.parse(chapter));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReadingScreen(
                                          updateReadingChapters:
                                              loadReadChapter,
                                          readingController: ReadingController(
                                              readingModel: ReadingModel(
                                            novel: widget.novel,
                                            chapter: int.parse(chapter),
                                            isOffline: widget.isOffline,
                                          ))))).then((_) {
                                // This block runs when you come back to the current screen
                                setState(() {
                                  // Update your state here
                                });
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Chương $chapter',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color:
                                        isRead ? Colors.white38 : Colors.white,
                                  ),
                                )));
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
                Text('$currentPage/$totalPages',
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
        ));
  }
}
