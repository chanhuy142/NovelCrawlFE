
import 'package:flutter/material.dart';
import 'package:novel_crawl/models/novel.dart';

import 'novel_card.dart';

class NovelCardGridView extends StatelessWidget {
  const NovelCardGridView({
    super.key,
    required this.novelsList,
    required this.isOffline,
    required this.onRefreshGridView,
  });

  final List<Novel> novelsList;
  final bool isOffline;
  final Function() onRefreshGridView;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          onRefreshGridView();
        },
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
              onRefreshGridView: onRefreshGridView,
            );
          },
        ),
      ),
    );
  }
}