import 'novel_detail.dart';

class Library {
    List<TruyenDetail> truyenDetail;

    Library({
        required this.truyenDetail,
    });

    factory Library.fromJson(Map<String, dynamic> json) => Library(
        truyenDetail: List<TruyenDetail>.from(json["TruyenDetail"].map((x) => TruyenDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "TruyenDetail": List<dynamic>.from(truyenDetail.map((x) => x.toJson())),
    };
}
