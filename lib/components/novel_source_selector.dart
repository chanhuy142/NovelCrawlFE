import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NovelSourceSelector extends StatefulWidget {
  NovelSourceSelector({super.key});

  @override
  State<NovelSourceSelector> createState() => _NovelSourceSelectorState();
}

class _NovelSourceSelectorState extends State<NovelSourceSelector> {
  List<String> novelSoucre = ['Truyện Full', 'Truyện Mới', 'Truyện Hot'];
  int selectedSource = 0;
  @override
  Widget build(BuildContext context) {
    return Wrap(children: <Widget>[
      ListView.builder(
          shrinkWrap: true,
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: novelSoucre.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedSource = index;
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
                            index == selectedSource ? Color(0xFFDFD82C) : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Row(
                        children: [
                          Text(novelSoucre[index],
                              style: TextStyle(
                                color: index == selectedSource
                                    ? Color(0xFFDFD82C)
                                    : Color(0xFFFFFFFF),
                                fontSize: 20,
                              )),
                          Spacer(),
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
