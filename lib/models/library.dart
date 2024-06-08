import 'novel.dart';

class Library {
    List<Novel> novels;

    Library({
        required this.novels,
    });

    factory Library.fromJson(Map<String, dynamic> json) => Library(
        novels: List<Novel>.from(json["NovelDetail"].map((x) => Novel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "NovelDetail": List<dynamic>.from(novels.map((x) => x.toJson())),
    };

    void copyFrom(Library newLibrary) {
      novels = newLibrary.novels;
    }
}
