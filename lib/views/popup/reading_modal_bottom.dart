import 'package:flutter/material.dart';
import 'package:novel_crawl/views/components/novel_source_selector.dart';
import 'package:novel_crawl/controllers/reading_controller.dart';
import 'package:novel_crawl/views/popup/download_popup.dart';
import 'package:novel_crawl/views/screens/settingscreen.dart';

class ReadingModalBottom extends StatefulWidget {
  const ReadingModalBottom(
      {super.key,
      required this.onChapterChanged,
      required this.onUpdated,
      required this.readingController});
  final ValueChanged<int> onChapterChanged;
  final ReadingController readingController;
  final Function() onUpdated;
  @override
  State<ReadingModalBottom> createState() => _ReadingModalBottomState();
}

class _ReadingModalBottomState extends State<ReadingModalBottom> {
  @override
  void initState() {
    super.initState();
  }

  void showDownloadDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DownloadPopup(
              novel: widget.readingController.readingModel.novel);
        });
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
                    Icon(
                      Icons.download,
                      color: Colors.white,
                    ),
                    Text(
                      'Tải về',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  widget.readingController.getPreviousChapter();
                  setState(() {
                    widget.onChapterChanged(
                        widget.readingController.readingModel.chapter);
                  });
                },
              ),
              Text(
                  '${widget.readingController.readingModel.chapter}/${widget.readingController.readingModel.novel.numberOfChapters}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  )),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  widget.readingController.getNextChapter();
                  setState(() {
                    widget.onChapterChanged(
                        widget.readingController.readingModel.chapter);
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
                                novelSources: widget
                                    .readingController
                                    .readingModel
                                    .allSourceChapterContent
                                    .chapters
                                    .map((e) => e.source)
                                    .toList(),
                                onUpdated: widget.onUpdated),
                            onUpdated: widget.onUpdated,
                          ));
                    });
              },
              child: Container(
                color: Colors.transparent,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    Text(
                      'Cài đặt',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
