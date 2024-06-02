
import 'package:flutter/material.dart';
import 'package:novel_crawl/components/novel_source_priority_selector.dart';
import 'package:novel_crawl/controllers/setting_controller.dart';
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
  SettingController settingController = SettingController.instance;
  
  @override
  void initState() {
    settingController.init();
    super.initState();
  }

  @override
  void dispose() {
    settingController.dispose();
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
                      color: settingController.setting.background,
                      border: Border.all(
                        color: const Color(0xFF83899F),
                        width: 2,
                      ),
                    ),
                    child: Text('Đây là định dạng của truyện sẽ được hiển thị',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: settingController.setting.color,
                            fontSize: settingController.setting.fontSize.toDouble(),
                            fontFamily: settingController.setting.font,
                            height: settingController.setting.lineSpacing.toDouble()))
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
                                itemCount: settingController.setting.colors.length,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        settingController.setBackgroundColorId(index);
                                        settingController.setColorId(3 - index);
                                        widget.onUpdated();
                                      });
                                    },
                                    child: Container(
                                      width: 40,
                                      margin: const EdgeInsets.only(left: 5),
                                      decoration: BoxDecoration(
                                        color: settingController.setting.colors[index],
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: index == settingController.setting.backgroundId
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
                          value: settingController.setting.fontSize.toDouble(),
                          min: 12,
                          max: 30,
                          divisions: 18,
                          label: settingController.setting.fontSize.toString(),
                          onChanged: (double value) {
                            setState(() {
                              settingController.setFontSize(value.round());
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
                          value: settingController.setting.lineSpacing.toDouble(),
                          min: 1,
                          max: 3,
                          divisions: 2,
                          label: settingController.setting.lineSpacing.toString(),
                          onChanged: (double value) {
                            setState(() {
                              settingController.setLineSpacing(value.round());
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
                              itemCount: settingController.setting.fonts.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      settingController.setFontFamilyId(index);
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
                                            color: index == settingController.setting.fontId
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
                                                settingController.setting.fonts[index],
                                                style: TextStyle(
                                                    color: index == settingController.setting.fontId
                                                        ? const Color(
                                                            0xFFDFD82C)
                                                        : const Color(
                                                            0xFFFFFFFF),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: settingController.setting.fonts[index]),
                                              ),
                                              const Spacer(),
                                              Visibility(
                                                visible: index == settingController.setting.fontId,
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
