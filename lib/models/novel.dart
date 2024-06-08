class Novel {
    String name;
    String cover;
    String url;
    String author;
    int numberOfChapters;
    String description;

    Novel({
        required this.name,
        required this.cover,
        required this.url,
        required this.author,
        required this.numberOfChapters,
        required this.description,
    });

    factory Novel.fromJson(Map<String, dynamic> json) => Novel(
        name: json["novelName"],
        cover: json["cover"],
        url: json["url"],
        author: json["author"],
        numberOfChapters: int.parse(json["numberOfChapters"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "novelName": name,
        "cover": cover,
        "url": url,
        "author": author,
        "numberOfChapters": numberOfChapters.toString(),
        "description": description,
    };

    void standardize() {
        name = name.trim();
        cover = cover.trim();
        url = url.trim();
        author = author.trim();
        description = description.trim();
    }
}