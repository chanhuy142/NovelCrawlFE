import 'novel_detail.dart';

class Library {
    List<NovelDetail> novelDetail;

    Library({
        required this.novelDetail,
    });

    factory Library.fromJson(Map<String, dynamic> json) => Library(
        novelDetail: List<NovelDetail>.from(json["NovelDetail"].map((x) => NovelDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "NovelDetail": List<dynamic>.from(novelDetail.map((x) => x.toJson())),
    };

    void copyFrom(Library newLibrary) {
      novelDetail = newLibrary.novelDetail;
    }
}
