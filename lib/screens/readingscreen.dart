import 'package:flutter/material.dart';
import 'package:novel_crawl/components/reading_view.dart';
import 'package:novel_crawl/controllers/setting_controller.dart';
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
  final NovelDetail novel;
  final int chapter;
  final bool isOffline;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  var _content = '';
  SettingController settingController = SettingController.instance;
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
      backgroundColor: settingController.setting.background,
      appBar: AppBar(
        backgroundColor: settingController.setting.background,
        title: Text('Chương $chapter - ${widget.novel.novelName}',
            style: TextStyle(color: settingController.setting.color)),
        iconTheme: IconThemeData(color: settingController.setting.color),
      ),
      body: _isLoading
          ? Container(
              color: settingController.setting.background,
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
                  content: _content),
              onTap: () {
                showModalBottom(context);
              }),
    );
  }
}
