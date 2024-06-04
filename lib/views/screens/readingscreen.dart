import 'package:flutter/material.dart';
import 'package:novel_crawl/views/components/reading_view.dart';
import 'package:novel_crawl/controllers/reading_controller.dart';
import 'package:novel_crawl/controllers/setting_controller.dart';
import 'package:novel_crawl/views/popup/reading_modal_bottom.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key, required this.readingController, this.updateReadingChapters = defaultFunction});
  final ReadingController readingController;
  final Function() updateReadingChapters;
  static void defaultFunction() {}
  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  SettingController settingController = SettingController.instance;

  bool _isLoading = true;

  @override
  void dispose() {
    // TODO: implement dispose
    widget.updateReadingChapters();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    settingController.init();
    widget.readingController.init(updateAllState);
  }

  void onChapterChanged(int chapter) {
    setState(() {
      _isLoading = true;
    });
    widget.readingController.readingModel.chapter = chapter;
    widget.readingController.changeContentWhenChangeChapter(updateAllState);
  }

  void updateAllState() {
    setState(() {
       widget.readingController.updateState();
      _isLoading = false;
    });
  }

  void showModalBottom(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ReadingModalBottom(
            onChapterChanged: onChapterChanged,
            onUpdated: updateAllState,
            readingController: widget.readingController,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingController.setting.background,
      appBar: AppBar(
        backgroundColor: settingController.setting.background,
        title: Text(
            'Chương ${widget.readingController.readingModel.chapter} - ${widget.readingController.readingModel.novel.novelName}',
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
                  content: widget.readingController.readingModel.content),
              onTap: () {
                showModalBottom(context);
              }),
    );
  }
}
