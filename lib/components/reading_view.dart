import 'package:flutter/material.dart';
import 'package:novel_crawl/controllers/setting_controller.dart';

class ReadingView extends StatelessWidget {
  const ReadingView({super.key, required this.content});
  final String content;
  
  @override
  Widget build(BuildContext context) {
    SettingController settingController = SettingController.instance;
    return SingleChildScrollView(
      child: Container(
        color: settingController.setting.background,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content,
            softWrap: true,
            style: TextStyle(
              fontSize: settingController.setting.fontSize.toDouble(),
              color: settingController.setting.color,
              height: settingController.setting.lineSpacing.toDouble(),
              fontFamily: settingController.setting.font,
            ),
        ),
        ),
      )
    );
  }
}