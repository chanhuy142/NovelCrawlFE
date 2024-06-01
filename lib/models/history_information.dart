import 'package:novel_crawl/models/novel_detail.dart';


class HistoryInfomation{
  NovelDetail novelDetail;
  int currentChapter;

  HistoryInfomation({required this.novelDetail, required this.currentChapter});

  factory HistoryInfomation.fromJson(Map<String, dynamic> json) => HistoryInfomation(
    novelDetail: NovelDetail.fromJson(json["novelDetail"]),
    currentChapter: json["currentChapter"],
  );

  Map<String, dynamic> toJson() => {
    "novelDetail": novelDetail.toJson(),
    "currentChapter": currentChapter,
  };
}