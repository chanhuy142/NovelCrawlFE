import 'package:flutter/material.dart';

import '../service/state_service.dart';

class NovelSourceSelector extends StatefulWidget {
  NovelSourceSelector({super.key, required this.novelSources, required this.onUpdated});
  List<String> novelSources;
  final Function() onUpdated;
  @override
  State<NovelSourceSelector> createState() => _NovelSourceSelectorState();
}

class _NovelSourceSelectorState extends State<NovelSourceSelector> {
  int selectedSource = 0;
  StateService stateService = StateService.instance;
  
  @override
  void initState() {
    // TODO: implement initState
    stateService.getSelectedSource().then((value) {
      setState(() {
        if(value == '' || !widget.novelSources.contains(value)) {
          selectedSource = 0;
        } else {
          selectedSource = widget.novelSources.indexOf(value);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.onUpdated();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: <Widget>[
      ListView.builder(
          shrinkWrap: true,
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.novelSources.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedSource = index;
                  stateService.saveSelectedSource(widget.novelSources[index]);
                });
              },
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    height: 33,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color:
                            index == selectedSource ? const Color(0xFFDFD82C) : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Row(
                        children: [
                          Text(widget.novelSources[index],
                              style: TextStyle(
                                color: index == selectedSource
                                    ? const Color(0xFFDFD82C)
                                    : const Color(0xFFFFFFFF),
                                fontSize: 20,
                              )),
                          const Spacer(),
                          Visibility(
                            visible: index == selectedSource,
                            child: const Icon(
                              Icons.check,
                              color: Color(0xFFDFD82C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            );
          }),
    ]);
  }
}
