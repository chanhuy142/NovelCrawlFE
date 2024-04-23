import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/models/library.dart';

class APIService {
  Library libraryFromJson(String str) => Library.fromJson(jsonDecode(str));
  //send to http://localhost/details
  //port 3000
  Future<Library> getNovelDetails() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.46:3000/details'));
    if (response.statusCode == 200) {
      return libraryFromJson(response.body);
    } else {
      throw Exception('Failed to load novel details');
    }
  }
}
