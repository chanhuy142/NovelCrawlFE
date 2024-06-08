import 'novel.dart';

class Library {
    List<Novel> novelDetail;

    Library({
        required this.novelDetail,
    });

    factory Library.fromJson(Map<String, dynamic> json) => Library(
        novelDetail: List<Novel>.from(json["NovelDetail"].map((x) => Novel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "NovelDetail": List<dynamic>.from(novelDetail.map((x) => x.toJson())),
    };

    void copyFrom(Library newLibrary) {
      novelDetail = newLibrary.novelDetail;
    }
}
