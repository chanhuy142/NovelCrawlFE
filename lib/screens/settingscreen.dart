import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:novel_crawl/components/novel_source_selector.dart';
import 'package:novel_crawl/components/novel_source_priority_selector.dart';

class SettingPage extends StatefulWidget {
  SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List<Color> colors = [
    Colors.black,
    Colors.white,
    const Color(0xFF3A3E48),
    const Color(0xFFFFF1C2),
  ];

  final List<String> fonts = [
    'Roboto',
    'Open Sans',
    'Lora',
    'Merriweather',
    'Dancing Script',
  ];

  List<String> novelSoucre = [
    'Truyện Full',
    'Tàng Thư Viện',
    'Truyện abcxyz',
  ];

  int selectedFont = 0;
  int selectedColor = 0;
  int fontSize = 16;
  int lineSpacing = 16;
  int selectedSource = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
            padding: //top padding
                const EdgeInsets.only(top: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Cài Đặt",
                    style: TextStyle(
                        color: Color(0xFF83899F),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.only(top: 15, bottom: 0),
                  child: Text(
                    'Nguồn Truyện',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                NovelSourcePrioritySelector(),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    children: [
                      const Text(
                        'Màu sắc',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      const Spacer(),
                      Expanded(
                        child: Container(
                          height: 30,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: colors.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = index;
                                    });
                                  },
                                  child: Container(
                                    width: 30,
                                    margin: EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      color: colors[index],
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: index == selectedColor
                                            ? Color(0xFFDFD82C)
                                            : Color(0xFF83899F),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    children: [
                      Text(
                        'Kích thước chữ',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            fontSize = max(12, fontSize - 1);
                          });
                        },
                        child: Icon(
                          size: 30,
                          Icons.remove,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      Container(
                        width: 30,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Color(0xFF3A3E47),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          fontSize.toString(),
                          style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            fontSize = min(20, fontSize + 1);
                          });
                        },
                        child: const Icon(
                          size: 30,
                          Icons.add,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    children: [
                      const Text(
                        'Giãn cách dòng',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            lineSpacing = max(12, lineSpacing - 1);
                          });
                        },
                        child: Icon(
                          size: 30,
                          Icons.remove,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      Container(
                        width: 30,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Color(0xFF3A3E47),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          lineSpacing.toString(),
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            lineSpacing = min(20, lineSpacing + 1);
                          });
                        },
                        child: const Icon(
                          size: 30,
                          Icons.add,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 0),
                  child: Text(
                    'Font chữ',
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                        scrollDirection: Axis.vertical,
                        itemCount: fonts.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedFont = index;
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
                                      color: index == selectedFont
                                          ? Color(0xFFDFD82C)
                                          : Colors.transparent,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          fonts[index],
                                          style: TextStyle(
                                              color: index == selectedFont
                                                  ? Color(0xFFDFD82C)
                                                  : Color(0xFFFFFFFF),
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: fonts[index]),
                                        ),
                                        Spacer(),
                                        Visibility(
                                          visible: index == selectedFont,
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
                  ),
              ],
            )));
  }
}
