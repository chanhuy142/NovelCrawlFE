class TruyenDetail {
    String tenTruyen;
    String cover;
    String url;
    String author;
    int numberOfChapters;
    String description;

    TruyenDetail({
        required this.tenTruyen,
        required this.cover,
        required this.url,
        required this.author,
        required this.numberOfChapters,
        required this.description,
    });

    factory TruyenDetail.fromJson(Map<String, dynamic> json) => TruyenDetail(
        tenTruyen: json["tenTruyen"],
        cover: json["cover"],
        url: json["url"],
        author: json["author"],
        numberOfChapters: int.parse(json["numberOfChapters"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "tenTruyen": tenTruyen,
        "cover": cover,
        "url": url,
        "author": author,
        "numberOfChapters": numberOfChapters.toString(),
        "description": description,
    };

    void standardize() {
        tenTruyen = tenTruyen.trim();
        cover = cover.trim();
        url = url.trim();
        author = author.trim();
        description = description.trim();
    }
}