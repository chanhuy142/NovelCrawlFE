import 'package:novel_crawl/models/unique_chapter_content.dart';

class AllSourceChapterContent{
  List<NovelChapterContent> chapterContents;

  AllSourceChapterContent({required this.chapterContents});

  factory AllSourceChapterContent.fromJson(Map<String, dynamic> json) => AllSourceChapterContent(
    chapterContents: List<NovelChapterContent>.from(json["TruyenChapter"].map((x) => NovelChapterContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TruyenChapter": List<dynamic>.from(chapterContents.map((x) => x.toJson())),
  };
}