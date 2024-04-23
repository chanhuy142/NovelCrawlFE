import 'package:flutter/material.dart';
import 'package:novel_crawl/components/reading_view.dart';
import 'package:novel_crawl/models/content_from_all_source.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/models/unique_chapter_content.dart';
import 'package:novel_crawl/service/api_service.dart';
import 'package:novel_crawl/service/state_service.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key, required this.novel, required this.chapter});
  final TruyenDetail novel;
  final int chapter;




  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {

  var _content = '';
  int _fontSize = 20;
  var _fontFamily = 'Arial';
  Color _color = Color(0xFFFFFFFF);
  var _spacing = 1;
  String _source = '';
  List<String> sources = [];  
  StateService stateService = StateService.instance;
  AllSourceChapterContent allSourceChapterContent = AllSourceChapterContent(chapterContents: []);





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

  void changeSource(String source) {
    setState(() {
      _source = source;
    });
  }




  @override
  void initState() {


    stateService.getSources().then((value) {
      setState(() {
        sources = value;
        changeSource(value[0]);
      });
    });

    try {
      APIService().getChapterContent(widget.novel, widget.chapter).then((value) {
        setState(() {
          allSourceChapterContent = value;

          if(value.chapterContents.isEmpty) {
            throw Exception('Lỗi không thể tải nội dung chương truyện.');
          }
          
          for(var source in sources) {
            print(source);
            if(allSourceChapterContent.chapterContents.where((element) => element.source == source).isNotEmpty) {
              changeContent(allSourceChapterContent.chapterContents.where((element) => element.source == source).first.content);
              break;
            }
          }


        });
      
      });
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