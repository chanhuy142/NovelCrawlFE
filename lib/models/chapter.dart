class Chapter
{
  String source;
  String content;

  Chapter({required this.source, required this.content});

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    source: json["source"],
    content: json["content"] ?? ''
  );

  Map<String, dynamic> toJson() => {
    "source": source,
    "content": content
  };
}