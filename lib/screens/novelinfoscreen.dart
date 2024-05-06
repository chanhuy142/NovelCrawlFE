import 'package:flutter/material.dart';
import 'package:novel_crawl/components/chapter_list_view.dart';
import 'package:novel_crawl/components/description_view.dart';
import 'package:novel_crawl/components/novel_info_view.dart';
import 'package:novel_crawl/components/task_bar.dart';
import 'package:novel_crawl/models/novel_detail.dart';

class NovelInfo extends StatelessWidget {
  const NovelInfo({super.key, required this.novelDetail, this.isOffline = false});
  final TruyenDetail novelDetail;
  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(novelDetail.tenTruyen, style: const TextStyle(color: Color(0xFFFFFFFF))),
        backgroundColor: const Color(0xFF000000),
        iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
      ),
      backgroundColor: const Color(0xFF000000),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                NovelInfoView(novelDetail: novelDetail),
                DescriptionView(description: novelDetail.description),
                SizedBox(
                  height: 500,
                  child: ChapterListView(chapterNumber: novelDetail.numberOfChapters, novel: novelDetail, isOffline: isOffline,)),
                ],
              ),
            ),
          ),
          TaskBar(novel: novelDetail, isOffline: isOffline),
        ],
      )
    );
  }
}
