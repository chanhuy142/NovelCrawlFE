import 'package:novel_crawl/models/chapter.dart';

class ChapterFactory{
  List<Chapter> chapters;

  ChapterFactory({required this.chapters});

  factory ChapterFactory.fromJson(Map<String, dynamic> json) => ChapterFactory(
    chapters: List<Chapter>.from(json["NovelChapter"].map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "NovelChapter": List<dynamic>.from(chapters.map((x) => x.toJson())),
  };
}