
import 'package:novel_crawl/models/content_from_all_source.dart';
import 'package:novel_crawl/models/novel_detail.dart';

class ReadingModel{
  NovelDetail novel;
  int chapter;
  bool isOffline;

  ReadingModel({required this.novel, required this.chapter, required this.isOffline});
  List<String> sources = [];
  String content = '';
  AllSourceChapterContent allSourceChapterContent =
      AllSourceChapterContent(chapterContents: []);
}