import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:novel_crawl/models/content_from_all_source.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/models/library.dart';
import 'package:novel_crawl/util/signedtounsigned.dart';

class APIService {
  Library libraryFromJson(String str) => Library.fromJson(jsonDecode(str));
  AllSourceChapterContent allSourceChapterContentFromJson(String str) =>
      AllSourceChapterContent.fromJson(jsonDecode(str));

  String localhost = 'http://192.168.1.19:3000';
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

  //send to http://localhost:3000/?tentruyen=@tentruyen&chapter=@chapter
  //ex: http://localhost:3000/?tentruyen=ngao-the-dan-than&chapter=5

  Future<AllSourceChapterContent> getChapterContent(
      TruyenDetail novel, int chapter) async {
    String request =
        '$localhost/?tentruyen=${SignedToUnsinged.standardizeName(novel.tenTruyen)}&chapter=$chapter';
    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var contentList = allSourceChapterContentFromJson(response.body);
      AllSourceChapterContent res =
          AllSourceChapterContent(chapterContents: []);
      for (int i = 0; i < contentList.chapterContents.length; i++) {
        if (contentList.chapterContents[i].content != "") {
          res.chapterContents.add(contentList.chapterContents[i]);
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
      var res = List<String>.from(json["TruyenSource"].map((x) => x));
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
 
  Future<Response> getExportFile(String name, String content, String fileType) async {
    try {
      String apiUrl = localhost + '/download';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'content': content,
          'name': name,
          'fileType': fileType,
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
