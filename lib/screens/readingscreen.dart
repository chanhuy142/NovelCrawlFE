import 'package:flutter/material.dart';
import 'package:novel_crawl/components/reading_view.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/service/api_service.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key, required this.novel, required this.chapter, required this.source});
  final TruyenDetail novel;
  final int chapter;
  final String source;


  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {

  var _content = '';
  var _fontSize = 16.0;
  var _fontFamily = 'Arial';
  var _color = 0xFFFFFFFF;
  var _spacing = 1;

  void changeContent(String content) {
    setState(() {
      _content = content;
    });
  }

  void changeFontSize(double fontSize) {
    setState(() {
      _fontSize = fontSize;
    });
  }

  void changeFontFamily(String fontFamily) {
    setState(() {
      _fontFamily = fontFamily;
    });
  }

  void changeColor(int color) {
    setState(() {
      _color = color;
    });
  }

  void changeSpacing(int spacing) {
    setState(() {
      _spacing = spacing;
    });
  }


  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {

    try {
      APIService().getChapterContent(widget.novel, widget.chapter, widget.source).then((value) => changeContent(value));
    } catch (e) {
      print(e);
    }
    return Scaffold(
      body: ReadingView(content: _content, fontSize: _fontSize, fontFamily: _fontFamily, color: _color, spacing: _spacing),
    );
  }
}