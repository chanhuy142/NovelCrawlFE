
import 'package:flutter/material.dart';
import 'package:novel_crawl/service/api_service.dart';
import 'package:novel_crawl/service/state_service.dart';

class NovelSourcePrioritySelector extends StatefulWidget {
  const NovelSourcePrioritySelector({super.key});

  @override
  State<NovelSourcePrioritySelector> createState() =>
      _NovelSourcePrioritySelectorState();
}

class _NovelSourcePrioritySelectorState
    extends State<NovelSourcePrioritySelector> {
  List<String> novelSources = [];
  int selectedSource = 0;
  StateService stateService = StateService.instance;

  @override
  void initState() {
    // TODO: implement initState
    stateService.getSources().then((value) {
      setState(() {
        novelSources = value;
      });
      APIService().getAllSources().then((value) => {
          setState(() {
            bool isDifferent = false;
            if (novelSources.length != value.length) {
              isDifferent = true;
            } else {
              for (int i = 0; i < novelSources.length; i++) {
                if (!novelSources.contains(value[i]) ||
                    !value.contains(novelSources[i])) {
                  isDifferent = true;
                  print('Different');
                  break;
                }
              }
            }

            if (isDifferent) {
              novelSources = value;
              stateService.saveSources(novelSources);
            }
          })
        });
    });
    
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    stateService.closeService();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: ReorderableListView(
        shrinkWrap: true,
        children: <Widget>[
          for (int index = 0; index < novelSources.length; index += 1)
            ListTile(
              contentPadding:
                  const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
              key: Key('$index'),
              title: SourceItem(
                  novelSource: novelSources[index], index: index + 1),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final String item = novelSources.removeAt(oldIndex);
            novelSources.insert(newIndex, item);
            stateService.saveSources(novelSources);
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
        color: const Color(0xFF3A3E47),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFF3A3E47),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Row(
          children: [
            Text('$index $novelSource',
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                )),
            const Spacer(),
            const Icon(
              Icons.menu,
              color: Color(0xFFFFFFFF),
            )
          ],
        ),
      ),
    );
  }
}
