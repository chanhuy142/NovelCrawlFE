class ContentParser {
  static String parseContent(String content) {
    //replace '\' with '\n'
    content = content.replaceAll('\\', '\n');
    return content;
  }
}