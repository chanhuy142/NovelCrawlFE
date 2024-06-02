class NovelDetail {
    String novelName;
    String cover;
    String url;
    String author;
    int numberOfChapters;
    String description;

    NovelDetail({
        required this.novelName,
        required this.cover,
        required this.url,
        required this.author,
        required this.numberOfChapters,
        required this.description,
    });

    factory NovelDetail.fromJson(Map<String, dynamic> json) => NovelDetail(
        novelName: json["novelName"],
        cover: json["cover"],
        url: json["url"],
        author: json["author"],
        numberOfChapters: int.parse(json["numberOfChapters"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "novelName": novelName,
        "cover": cover,
        "url": url,
        "author": author,
        "numberOfChapters": numberOfChapters.toString(),
        "description": description,
    };

    void standardize() {
        novelName = novelName.trim();
        cover = cover.trim();
        url = url.trim();
        author = author.trim();
        description = description.trim();
    }
}