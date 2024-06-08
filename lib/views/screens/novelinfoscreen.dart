import 'package:flutter/material.dart';
import 'package:novel_crawl/views/components/novel_info_tabcontrol.dart';
import 'package:novel_crawl/views/components/novel_info_view.dart';
import 'package:novel_crawl/views/components/task_bar.dart';
import 'package:novel_crawl/models/novel.dart';

class NovelInfo extends StatelessWidget {
  const NovelInfo({super.key, required this.novelDetail, this.isOffline = false});
  final Novel novelDetail;
  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(novelDetail.name, style: const TextStyle(color: Color(0xFFFFFFFF))),
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
                SizedBox(
                  height: 500,
                  child: NovelInfoTabControl(novelDetail: novelDetail, isOffline: isOffline)),
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
