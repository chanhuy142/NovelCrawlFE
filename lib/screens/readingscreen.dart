import 'package:flutter/material.dart';
import 'package:novel_crawl/components/reading_view.dart';
import 'package:novel_crawl/models/content_from_all_source.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/popup/reading_modal_bottom.dart';
import 'package:novel_crawl/service/api_service.dart';
import 'package:novel_crawl/service/file_service.dart';
import 'package:novel_crawl/service/history_service.dart';
import 'package:novel_crawl/service/state_service.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen(
      {super.key,
      required this.novel,
      required this.chapter,
      required this.isOffline});
  final TruyenDetail novel;
  final int chapter;
  final bool isOffline;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  var _content = '';
  int _fontSize = 20;
  var _fontFamily = 'Arial';
  Color _color = const Color(0xFFFFFFFF);
  Color _backgroundColor = const Color(0xFF000000);
  var _spacing = 1;
  int chapter = 1;
  List<String> sources = [];
  bool _isLoading = true;

  StateService stateService = StateService.instance;
  AllSourceChapterContent allSourceChapterContent =
      AllSourceChapterContent(chapterContents: []);

  FileService fileService = FileService.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    HistoryService.instance.updateNovelHistory(widget.novel, chapter);
    super.dispose();
  }

  void updateAllState() {
    stateService.getSelectedSource().then((value) {
      setState(() {
        changeContent(allSourceChapterContent.chapterContents
            .where((element) => element.source == value)
            .first
            .content);
      });
    });

    stateService.getSources().then((value) {
      setState(() {
        sources = value;
      });
    });

    stateService.getFontSize().then((value) {
      setState(() {
        _fontSize = value;
      });
    });

    stateService.getLineSpacing().then((value) {
      setState(() {
        _spacing = value;
      });
    });

    stateService.getFontFamily().then((value) {
      setState(() {
        _fontFamily = value;
      });
    });

    stateService.getColor().then((value) {
      setState(() {
        _color = value;
      });
    });

    stateService.getBackgroundColor().then((value) {
      setState(() {
        _backgroundColor = value;
      });
    });
  }

  void onChapterChanged(int chapter) {
    setState(() {
      this.chapter = chapter;
      changeContentWhenChangeChapter();
    });
  }

  void changeContent(String content) {
    setState(() {
      _content = content;
      _isLoading = false;
    });
  }

  void changeFontSize(int fontSize) {
    setState(() {
      _fontSize = fontSize;
    });
  }

  void changeFontFamily(String fontFamily) {
    setState(() {
      _fontFamily = fontFamily;
    });
  }

  void changeColor(Color color) {
    setState(() {
      _color = color;
    });
  }

  void changeBackgroundColor(Color backgroundColor) {
    setState(() {
      _backgroundColor = backgroundColor;
    });
  }

  void changeSpacing(int spacing) {
    setState(() {
      _spacing = spacing;
    });
  }

  void selectContentFromPrioritySource() {
    for (var source in sources) {
      if (allSourceChapterContent.chapterContents
          .where((element) => element.source == source)
          .isNotEmpty) {
        changeContent(allSourceChapterContent.chapterContents
            .where((element) => element.source == source)
            .first
            .content);
        stateService.saveSelectedSource(source);
        break;
      }
    }
  }

  void changeContentWhenChangeChapter() {
    try {
      _isLoading = true;
      if (widget.isOffline) {
        fileService.getChapterContent(widget.novel, chapter).then((value) {
          setState(() {
            allSourceChapterContent = value;
            if (value.chapterContents.isEmpty) {
              throw Exception('Lỗi không thể tải nội dung chương truyện.');
            }

            selectContentFromPrioritySource();

            _isLoading = false;
          });
        });
      } else {
        APIService().getChapterContent(widget.novel, chapter).then((value) {
          setState(() {
            allSourceChapterContent = value;

            if (value.chapterContents.isEmpty) {
              throw Exception('Lỗi không thể tải nội dung chương truyện.');
            }

            selectContentFromPrioritySource();

            _isLoading = false;
          });
        }).catchError((e){
          setState(() {
            _isLoading = false;
            _content = 'Không thể tải nội dung chương truyện.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n';
          });
        });
      }
    } catch (e) {
      _isLoading = false;
    }
  }

  @override
  void initState() {
    chapter = widget.chapter;
    changeContentWhenChangeChapter();
    updateAllState();
    super.initState();
  }

  void showModalBottom(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ReadingModalBottom(
            currentChapter: chapter,
            novel: widget.novel,
            onChapterChanged: onChapterChanged,
            sources: allSourceChapterContent.chapterContents
                .map((e) => e.source)
                .toList(),
            onUpdated: updateAllState,
            isOffline: widget.isOffline,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        title: Text('Chương $chapter - ${widget.novel.tenTruyen}',
            style: TextStyle(color: _color)),
        iconTheme: IconThemeData(color: _color),
      ),
      body: _isLoading
          ? Container(
              color: _backgroundColor,
              height: double.infinity,
              width: double.infinity,
              child: const SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            )
          : GestureDetector(
              child: ReadingView(
                  content: _content,
                  fontSize: _fontSize,
                  fontFamily: _fontFamily,
                  color: _color,
                  spacing: _spacing,
                  backgroundColor: _backgroundColor),
              onTap: () {
                showModalBottom(context);
              }),
    );
  }
}
