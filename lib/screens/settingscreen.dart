import 'dart:math';

import 'package:flutter/material.dart';
import 'package:novel_crawl/components/novel_source_priority_selector.dart';
import 'package:novel_crawl/service/state_service.dart';

class SettingPage extends StatefulWidget {
  final Widget novelSourceSelector;
  final Function() onUpdated ;
  const SettingPage({super.key, this.novelSourceSelector = const NovelSourcePrioritySelector(), this.onUpdated = defaultFunction});
  
  static void defaultFunction() {}
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<String> novelSoucre = [
    'Truyện Full',
    'Tàng Thư Viện',
    'Truyện abcxyz',
  ];
  StateService stateService = StateService.instance;
  int selectedFont = 0;
  int selectedColor = 0;
  int selectedBackground = 0;
  int fontSize = 16;
  int lineSpacing = 16;
  int selectedSource = 0;

  List<Color> colors = [];

  List<String> fonts = [];

  @override
  void initState() {
    colors = stateService.getColorList();
    fonts = stateService.getFontFamilyList();
    stateService.getFontSize().then((value) {
      setState(() {
        fontSize = value;
      });
    });

    stateService.getLineSpacing().then((value) {
      setState(() {
        lineSpacing = value;
      });
    });

    stateService.getFontFamilyID().then((value) {
      setState(() {
        selectedFont = value;
      });
    });

    stateService.getColorID().then((value) {
      setState(() {
        selectedColor = value;
      });
    });

    stateService.getBackgroundColorID().then((value) {
      setState(() {
        selectedBackground = value;
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
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
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
                  widget.novelSourceSelector,
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(
                      children: [
                        const Text(
                          'Màu nền',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                        const Spacer(),
                        Expanded(
                          child: SizedBox(
                            height: 30,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: colors.length,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {                                      
                                      setState(() {                                       
                                        selectedBackground = index;
                                        stateService.saveBackgroundColorID(index);
                                        widget.onUpdated();
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      margin: const EdgeInsets.only(left: 5),
                                      decoration: BoxDecoration(
                                        color: colors[index],
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: index == selectedBackground
                                              ? const Color(0xFFDFD82C)
                                              : const Color(0xFF83899F),
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
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(
                      children: [
                        const Text(
                          'Màu chữ',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                        const Spacer(),
                        Expanded(
                          child: SizedBox(
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
                                        stateService.saveColorID(index);
                                        widget.onUpdated();
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      margin: const EdgeInsets.only(left: 5),
                                      decoration: BoxDecoration(
                                        color: colors[index],
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: index == selectedColor
                                              ? const Color(0xFFDFD82C)
                                              : const Color(0xFF83899F),
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
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(
                      children: [
                        const Text(
                          'Kích thước chữ',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              fontSize = max(12, fontSize - 1);
                              stateService.saveFontSize(fontSize);
                              widget.onUpdated();
                            });
                          },
                          child: const Icon(
                            size: 30,
                            Icons.remove,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Container(
                          width: 30,
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3A3E47),
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
                              fontSize = min(30, fontSize + 1);
                              stateService.saveFontSize(fontSize);
                              widget.onUpdated();
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
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(
                      children: [
                        const Text(
                          'Giãn cách dòng',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              lineSpacing = max(1, lineSpacing - 1);
                              stateService.saveLineSpacing(lineSpacing);
                              widget.onUpdated();
                            });
                          },
                          child: const Icon(
                            size: 30,
                            Icons.remove,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        Container(
                          width: 30,
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3A3E47),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            lineSpacing.toString(),
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
                              lineSpacing = min(3, lineSpacing + 1);
                              stateService.saveLineSpacing(lineSpacing);
                              widget.onUpdated();
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
                  SizedBox(
                    height: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                        stateService.saveFontFamilyID(index);
                                        widget.onUpdated();
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
                                                  ? const Color(0xFFDFD82C)
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
                                                          ? const Color(0xFFDFD82C)
                                                          : const Color(0xFFFFFFFF),
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: fonts[index]),
                                                ),
                                                const Spacer(),
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
                    ),
                  ),
                ],
              )),
        ));
  }
}
