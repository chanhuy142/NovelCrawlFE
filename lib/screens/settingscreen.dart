
import 'package:flutter/material.dart';
import 'package:novel_crawl/components/novel_source_priority_selector.dart';
import 'package:novel_crawl/service/state_service.dart';

class SettingPage extends StatefulWidget {
  final Widget novelSourceSelector;
  final Function() onUpdated;
  const SettingPage(
      {super.key,
      this.novelSourceSelector = const NovelSourcePrioritySelector(),
      this.onUpdated = defaultFunction});

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
  int lineSpacing = 1;
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
                  const EdgeInsets.only(top: 35, left: 20, right: 20),
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
                    padding: EdgeInsets.only(top: 15, bottom: 0),
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
                  Container(
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                      color: colors[selectedBackground],
                      border: Border.all(
                        color: const Color(0xFF83899F),
                        width: 2,
                      ),
                    ),
                    child: Text('Đây là định dạng của truyện sẽ được hiển thị',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: colors[selectedColor],
                            fontSize: fontSize.toDouble(),
                            fontFamily: fonts[selectedFont],
                            height: lineSpacing.toDouble()))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        const Text(
                          'Màu nền',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(right: 20),
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
                                        selectedColor = 3-index;
                                        stateService.saveColorID(3-index);
                                        widget.onUpdated();
                                      });
                                    },
                                    child: Container(
                                      width: 40,
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
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                        Slider(
                          value: fontSize.toDouble(),
                          min: 12,
                          max: 30,
                          divisions: 18,
                          label: fontSize.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              fontSize = value.round();
                              stateService.saveFontSize(fontSize);
                              widget.onUpdated();
                            });
                          },
                          activeColor: const Color(0xFFDFD82C),
                          inactiveColor: const Color(0xFF3A3E47),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                        Slider(
                          value: lineSpacing.toDouble(),
                          min: 1,
                          max: 3,
                          divisions: 2,
                          label: lineSpacing.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              lineSpacing = value.round();
                              stateService.saveLineSpacing(lineSpacing);
                              widget.onUpdated();
                            });
                          },
                          activeColor: const Color(0xFFDFD82C),
                          inactiveColor: const Color(0xFF3A3E47),
                          
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
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 20, right: 20),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        height: 33,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                                        ? const Color(
                                                            0xFFDFD82C)
                                                        : const Color(
                                                            0xFFFFFFFF),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.normal,
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
