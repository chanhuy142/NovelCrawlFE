import 'package:flutter/material.dart';
import 'package:novel_crawl/controllers/service/file_service.dart';

import '../components/novel_card_grid_view.dart';
import '../../models/novel_detail.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  List<NovelDetail> novelsList = [];

  void loadHistory() {
    FileService.instance.getNovelList().then((value) {
      setState(() {
        novelsList = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadHistory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: //top padding
            const EdgeInsets.only(top: 35),
        child: 
          Column(
            children: [
              const Text(
                'Truyện đã tải xuống',
                style: TextStyle(
                    color: Color(0xFF83899F),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              NovelCardGridView(novelsList: novelsList, isOffline: true, onRefreshGridView: loadHistory)
            ],
          ),
      ),
    );
  }
}
