import 'package:flutter/material.dart';
import 'package:novel_crawl/controllers/setting_controller.dart';

class FontSizeSettingSection extends StatelessWidget {
  const FontSizeSettingSection({
    super.key,
    required this.settingController,
    required this.onUpdated,
  });

  final SettingController settingController;
  final Function() onUpdated;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              settingController.setFontSize(value.round());
              onUpdated();
            },
            activeColor: const Color(0xFFDFD82C),
            inactiveColor: const Color(0xFF3A3E47),
          ),
        ],
      ),
    );
  }
}
