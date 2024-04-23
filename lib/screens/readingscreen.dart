import 'package:flutter/material.dart';
import 'package:novel_crawl/components/reading_view.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/service/api_service.dart';
import 'package:novel_crawl/service/state_service.dart';

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
  int _fontSize = 20;
  var _fontFamily = 'Arial';
  Color _color = Color(0xFFFFFFFF);
  var _spacing = 1;
  StateService stateService = StateService.instance;



  void changeContent(String content) {
    setState(() {
      _content = content;
    });
  }

  void changeFontSize(int fontSize) {
    setState(() {
      _fontSize = fontSize;
    });
  }

  void changeFontFamily(String fontFamily) {
    setState(() {
      _fontFamily = fontFamily;
    });
  }

  void changeColor(Color color) {
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

    try {
      APIService().getChapterContent(widget.novel, widget.chapter, widget.source).then((value) => changeContent(value));
    } catch (e) {
      print(e);
    }

    stateService.getFontSize().then((value) {
      setState(() {
        _fontSize = value;
      });
    });

    stateService.getLineSpacing().then((value) {
      setState(() {
        _spacing = value;
      });
    });

    stateService.getFontFamily().then((value) {
      setState(() {
        _fontFamily = value;
      });
    });

    stateService.getColor().then((value) {
      setState(() {
        _color = value;
      });
    });
    
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      body: ReadingView(content: _content, fontSize: _fontSize, fontFamily: _fontFamily, color: _color, spacing: _spacing),
    );
  }
}