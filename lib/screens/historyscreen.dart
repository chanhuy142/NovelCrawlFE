import 'package:flutter/material.dart';

import '../components/novel_card_grid_view.dart';
import '../models/novel_detail.dart';
import '../service/history_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}



class _HistoryPageState extends State<HistoryPage> {
  List<TruyenDetail> novelsList = [];

  @override
  void initState() {
    // TODO: implement initState
    HistoryService.instance.getHistoryList().then((value) {
      setState(() {
        novelsList = value;
      });
    });
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
                'Lịch sử đọc truyện',
                style: TextStyle(
                    color: Color(0xFF83899F),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              NovelCardGridView(novelsList: novelsList, isOffline: false)
            ],
          ),
      ),
    );
  }
}
