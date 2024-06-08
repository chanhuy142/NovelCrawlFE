
import 'package:novel_crawl/models/chapter_factory.dart';
import 'package:novel_crawl/models/novel.dart';

class ReadingModel{
  Novel novel;
  int chapter;
  bool isOffline;

  ReadingModel({required this.novel, required this.chapter, required this.isOffline});
  List<String> sources = [];
  String content = '';
  ChapterFactory allSourceChapterContent =
      ChapterFactory(chapters: []);
}