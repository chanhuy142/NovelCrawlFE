import 'package:flutter/material.dart';
import 'package:novel_crawl/views/components/chapter_list_view.dart';
import 'package:novel_crawl/views/components/description_view.dart';
import 'package:novel_crawl/models/novel_detail.dart';

class NovelInfoTabControl extends StatelessWidget {
  const NovelInfoTabControl({super.key, required this.novelDetail, this.isOffline = false});
  final NovelDetail novelDetail;
  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
  length: 2,
  child: Scaffold(
    backgroundColor: const Color(0xFF000000),
    appBar: AppBar(
      backgroundColor: const Color(0xFF000000),
      automaticallyImplyLeading: false,
      flexibleSpace: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TabBar(
            isScrollable: false,
            labelColor: Color(0xFFFFFFFF),
            labelStyle: TextStyle(fontSize: 20),
            
            tabs: [
              Tab(
                text:  'Giới thiệu',
              ),
              Tab(
                text: 'Danh sách chương',
              ),

            ],
          )
        ],
      ),
    ),
    body: TabBarView(
      children: [
        DescriptionView(description: novelDetail.description),
        ChapterListView(chapterNumber: novelDetail.numberOfChapters, novel: novelDetail, isOffline: isOffline),
      ],
    ),
  ),
);
  }
}