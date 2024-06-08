import 'package:novel_crawl/models/chapter.dart';

class ChapterFactory{
  List<Chapter> chapterFactory;

  ChapterFactory({required this.chapterFactory});

  factory ChapterFactory.fromJson(Map<String, dynamic> json) => ChapterFactory(
    chapterFactory: List<Chapter>.from(json["NovelChapter"].map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "NovelChapter": List<dynamic>.from(chapterFactory.map((x) => x.toJson())),
  };
}