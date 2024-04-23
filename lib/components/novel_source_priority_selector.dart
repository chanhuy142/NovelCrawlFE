import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NovelSourcePrioritySelector extends StatefulWidget {
  NovelSourcePrioritySelector({super.key});

  @override
  State<NovelSourcePrioritySelector> createState() =>
      _NovelSourcePrioritySelectorState();
}

class _NovelSourcePrioritySelectorState
    extends State<NovelSourcePrioritySelector> {
  List<String> novelSources = ['Truyện Full', 'Truyện Mới', 'Truyện Hot'];
  int selectedSource = 0;

    @override
  Widget build(BuildContext context) {
    return Expanded(
      flex : 0,
      child: ReorderableListView(
        shrinkWrap: true,
        children: <Widget>[
          for (int index = 0; index < novelSources.length; index += 1)
            ListTile(
              contentPadding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
              key: Key('$index'),
              title: SourceItem(novelSource: novelSources[index], index: index + 1),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final String item = novelSources.removeAt(oldIndex);
            novelSources.insert(newIndex, item);
          });
        },
      ),
    );
  }
}

class SourceItem extends StatelessWidget {
  SourceItem({super.key, required this.novelSource, required this.index});

  final String novelSource;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xFF3A3E47),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(0xFF3A3E47),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Row(
          children: [
            Text(index.toString() + ' ' + novelSource,
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                )),
            Spacer(),
            Icon(
              Icons.menu,
              color: Color(0xFFFFFFFF),
            )
          ],
        ),
      ),
    );
  }
}
