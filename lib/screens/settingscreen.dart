import 'package:flutter/material.dart';
import 'package:novel_crawl/components/colorsettingsection.dart';
import 'package:novel_crawl/components/fontfamilysettingsection.dart';
import 'package:novel_crawl/components/fontsizesettingsection.dart';
import 'package:novel_crawl/components/linespacingsettingsection.dart';
import 'package:novel_crawl/components/novel_source_priority_selector.dart';
import 'package:novel_crawl/components/preview_section.dart';
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

  void onUpdated() {
    setState(() {});
    widget.onUpdated();
  }

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
                  PreviewSection(settingController: settingController),
                  ColorSettingSection(
                      settingController: settingController,
                      onUpdated: onUpdated),
                  FontSizeSettingSection(
                    settingController: settingController,
                    onUpdated: onUpdated,
                  ),
                  LineSpacingSettingSection(
                      settingController: settingController,
                      onUpdated: onUpdated),
                  FontFamilySettingSection(settingController: settingController, onUpdated: onUpdated),
                ],
              )),
        ));
  }
}

