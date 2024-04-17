class TruyenDetail {
    String tenTruyen;
    String cover;
    String url;

    TruyenDetail({
        required this.tenTruyen,
        required this.cover,
        required this.url,
    });

    factory TruyenDetail.fromJson(Map<String, dynamic> json) => TruyenDetail(
        tenTruyen: json["tenTruyen"],
        cover: json["cover"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "tenTruyen": tenTruyen,
        "cover": cover,
        "url": url,
    };
}