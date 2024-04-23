class NovelChapterContent
{
  String source;
  String content;

  NovelChapterContent({required this.source, required this.content});

  factory NovelChapterContent.fromJson(Map<String, dynamic> json) => NovelChapterContent(
    source: json["source"],
    content: json["content"] ?? ''
  );

  Map<String, dynamic> toJson() => {
    "source": source,
    "content": content
  };
}