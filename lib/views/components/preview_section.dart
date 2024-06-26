import 'package:flutter/material.dart';
import 'package:novel_crawl/controllers/setting_controller.dart';

class PreviewSection extends StatelessWidget {
  const PreviewSection({
    super.key,
    required this.settingController,
  });

  final SettingController settingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
          alignment: Alignment.centerLeft,
         child: const Text(
            'Preview',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
       ),
        Container(
            height: 100,
            margin: const EdgeInsets.only(bottom: 15),
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
                    height: settingController.setting.lineSpacing.toDouble()))),
      ],
    );
  }
}
