import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:novel_crawl/models/chapter_factory.dart';
import 'package:novel_crawl/models/novel.dart';
import 'package:novel_crawl/models/library.dart';

class APIService {
  Library libraryFromJson(String str) => Library.fromJson(jsonDecode(str));
  ChapterFactory chapterFactoryFromJson(String str) =>
      ChapterFactory.fromJson(jsonDecode(str));

  String localhost = 'http://192.168.1.32:3000';
  //send to http://localhost/details
  //port 3000
  Future<Library> getNovelDetails() async {
    final response = await http.get(Uri.parse('$localhost/details'));
    if (response.statusCode == 200) {
      return libraryFromJson(response.body);
    } else {
      throw Exception('Failed to load novel details');
    }
  }

  Future<Library> getSearchedNovelDetails(String search) async {
    final response =
        await http.get(Uri.parse('$localhost/search?keyword=$search'));
    if (response.statusCode == 200) {
      return libraryFromJson(response.body);
    } else {
      throw Exception('Failed to load novel details');
    }
  }

  //send to http://localhost:3000/?novelName=@novelName&chapter=@chapter
  //ex: http://localhost:3000/?novelName=ngao-the-dan-than&chapter=5

  Future<ChapterFactory> getChapterContent(
      Novel novel, int chapter) async {
    String url = novel.url;
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    Uri uri = Uri.parse(url);
    String lastPart = uri.pathSegments.last;
    String request =
        '$localhost/?novelName=$lastPart&chapter=$chapter';
    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var contentList = chapterFactoryFromJson(response.body);
      ChapterFactory res =
          ChapterFactory(chapters: []);
      for (int i = 0; i < contentList.chapters.length; i++) {
        if (contentList.chapters[i].content != "") {
          res.chapters.add(contentList.chapters[i]);
        }
      }

      return res;
    } else {
      throw Exception('Lỗi không thể tải nội dung chương truyện.');
    }
  }

  Future<List<String>> getAllSources() async {
    final response = await http.get(Uri.parse('$localhost/source'));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var res = List<String>.from(json["NovelSource"].map((x) => x));
      return res;
    } else {
      throw Exception('Failed to load sources');
    }
  }

  Future<List<String>> getFileTypes() async {
    final response = await http.get(Uri.parse('$localhost/filetypes'));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var res = List<String>.from(json["FileType"].map((x) => x));
      return res;
    } else {
      throw Exception('Failed to load file types');
    }
  }

  Future<Response> getExportFile(String name, String content, String fileType,
      String author, String coverImage) async {
    try {
      String apiUrl = '$localhost/download';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'content': content,
          'name': name,
          'fileType': fileType,
          'author': author,
          'coverImage': coverImage
          // Add any other data you want to send in the body
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Successful POST request, handle the response here
        print(response.body);
        return response;
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print("Error: $e");
      return Response('Failed to post data', 500);
    }
  }
}
