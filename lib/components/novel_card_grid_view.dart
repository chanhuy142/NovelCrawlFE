
import 'package:flutter/material.dart';
import 'package:novel_crawl/models/novel_detail.dart';

import 'novel_card.dart';

class NovelCardGridView extends StatelessWidget {
  const NovelCardGridView({
    super.key,
    required this.novelsList,
    required this.isOffline,
  });

  final List<TruyenDetail> novelsList;
  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: novelsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (context, index) {
          return NovelCard(
            novelDetail: novelsList[index],
            isOffline: isOffline,
          );
        },
      ),
    );
  }
}