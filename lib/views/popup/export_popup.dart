import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:novel_crawl/views/components/file_type_selector.dart';
import 'package:novel_crawl/models/chapter_factory.dart';
import 'package:novel_crawl/models/novel.dart';
import 'package:novel_crawl/controllers/service/api_service.dart';
import 'package:novel_crawl/controllers/service/export_service.dart';
import 'package:novel_crawl/controllers/service/state_service.dart';

class ExportPopup extends StatefulWidget {
  const ExportPopup({super.key, required this.novel});
  final Novel novel;

  @override
  State<ExportPopup> createState() => _ExportPopupState();
}

class _ExportPopupState extends State<ExportPopup> {
  bool _isLoading = false;
  final _ChapterController = TextEditingController();
  ChapterFactory allSourceChapterContent =
      ChapterFactory(chapters: []);

  final APIService apiService = APIService();
  final StateService stateService = StateService.instance;

  List<String> sources = [];
  String _content = '';
  String fileType = '';

  void changeFileType(String type) {
    setState(() {
      fileType = type;
    });
  }

  void selectContentFromPrioritySource() {
    for (var source in sources) {
      if (allSourceChapterContent.chapters
          .where((element) => element.source == source)
          .isNotEmpty) {
        changeContent(allSourceChapterContent.chapters
            .where((element) => element.source == source)
            .first
            .content);
        stateService.saveSelectedSource(source);
        break;
      }
    }
  }

  void changeContent(String content) {
    setState(() {
      _content = content;
    });
  }

  void exportNovel(String novelName, int chapter, String author, String cover) {
    setLoading(true);
    APIService().getChapterContent(widget.novel, chapter).then((value) {
      setState(() {
        allSourceChapterContent = value;
        if (value.chapters.isEmpty) {
          throw Exception('Lỗi không thể tải nội dung chương truyện.');
        }
        selectContentFromPrioritySource();
        print(fileType);
        APIService().getExportFile('$novelName - Chương $chapter', _content, fileType, author, cover).then((value) {
          ExportService.writeCounter(value.bodyBytes, '$novelName - Chương $chapter.$fileType').then((value){
            Navigator.of(context).pop();
            setLoading(false);
            }).catchError((e){
              Navigator.of(context).pop();
              setLoading(false);
            });
        });
      });
    }).catchError((e) {
      setState(() {
        _isLoading = false;
        _content =
            'Không thể tải nội dung chương truyện.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n';
      });
    });
  }

  void setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateService.getSources().then((value) {
      setState(() {
        sources = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AlertDialog(
        backgroundColor: Colors.black,
        title: const Center(
            child: Text(
          'Xuất truyện',
          style: TextStyle(color: Colors.white),
        )),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Chương số: ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: _ChapterController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: 'Nhập chương cần xuất',
                    hintStyle: TextStyle(color: Colors.white38)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Loại file: ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FileTypeSelector(onFileTypeChanged: changeFileType),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Hủy',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              try {
                int chapter = int.parse(_ChapterController.text);
                if (chapter < 1 || chapter > widget.novel.numberOfChapters) {
                  _ChapterController.text = "1";
                  return;
                }
                exportNovel(widget.novel.name, chapter, widget.novel.author, widget.novel.cover);
              } catch (e) {
                print(e);
                Navigator.of(context).pop();
              }
            },
            child: const Text(
              'Xuất',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      _isLoading
          ? Container(
              color:
                  Colors.black.withOpacity(0.5), // Semi-transparent black color
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(),
    ]);
  }
}
