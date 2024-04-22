import 'package:flutter/material.dart';

import '../components/novel_card_grid_view.dart';
import '../models/novel_detail.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final List<TruyenDetail> novelsList = [];

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
              NovelCardGridView(novelsList: novelsList)
            ],
          ),
      ),
    );
  }
}
