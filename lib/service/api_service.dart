import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:novel_crawl/models/content_from_all_source.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/models/library.dart';
import 'package:novel_crawl/util/signedtounsigned.dart';
import 'package:novel_crawl/util/content_parser.dart';

class APIService {
  Library libraryFromJson(String str) => Library.fromJson(jsonDecode(str));
  AllSourceChapterContent allSourceChapterContentFromJson(String str) =>
      AllSourceChapterContent.fromJson(jsonDecode(str));

  String localhost = 'http://192.168.1.7:3000';
  //send to http://localhost/details
  //port 3000
  Future<Library> getNovelDetails() async {
    final response =
        await http.get(Uri.parse(localhost + '/details'));
    if (response.statusCode == 200) {
      return libraryFromJson(response.body);
    } else {
      throw Exception('Failed to load novel details');
    }
  }

  //send to http://localhost:3000/?tentruyen=@tentruyen&chapter=@chapter
  //ex: http://localhost:3000/?tentruyen=ngao-the-dan-than&chapter=5

  Future<String> getChapterContent(
      TruyenDetail novel, int chapter, String source) async {
    String request = localhost + '/?tentruyen=' + SignedToUnsinged.standardizeName(novel.tenTruyen) + '&chapter=' + chapter.toString();
    final response = await http.get(Uri.parse(
        request));
    print(response.body);
    if (response.statusCode == 200) {
      var contentList = allSourceChapterContentFromJson(response.body);
      var content = contentList.chapterContents
          .firstWhere((element) => element.source == source); 
      
      if(content.content == null) {
        throw Exception('Lỗi không thể tải nội dung chương truyện từ nguồn này');
      }
        

      return ContentParser.parseContent(content.content);
    } else {
      throw Exception('Lỗi không thể tải nội dung chương truyện từ nguồn này');
    }
  }

  Future<List<String>> getAllSources() async {
    final response =
        await http.get(Uri.parse(localhost + '/source'));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var res = List<String>.from(json["TruyenSource"].map((x) => x));
      return res;
    } else {
      throw Exception('Failed to load sources');
    }
  }
}
