import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:novel_crawl/components/chapter_list_view.dart';
import 'package:novel_crawl/components/description_view.dart';
import 'package:novel_crawl/components/novel_info_view.dart';
import 'package:novel_crawl/components/task_bar.dart';
import 'package:novel_crawl/models/novel_detail.dart';

class NovelInfo extends StatelessWidget {
  const NovelInfo({super.key, required this.novelDetail});
  final TruyenDetail novelDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                NovelInfoView(novelDetail: novelDetail),
                DescriptionView(description: novelDetail.description),
                Container(
                  height: 500,
                  child: ChapterListView(chapterNumber: novelDetail.numberOfChapters)),
                ],
              ),
            ),
          ),
          TaskBar(novel: novelDetail),
        ],
      )
    );
  }
}
