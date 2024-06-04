import 'package:flutter/material.dart';
import 'package:novel_crawl/controllers/setting_controller.dart';

class LineSpacingSettingSection extends StatelessWidget {
  const LineSpacingSettingSection({
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
            'Giãn cách dòng',
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20,
                fontWeight: FontWeight.normal),
          ),
          const Spacer(),
          Slider(
            value:
                settingController.setting.lineSpacing.toDouble(),
            min: 1,
            max: 3,
            divisions: 2,
            label:
                settingController.setting.lineSpacing.toString(),
            onChanged: (double value) {
              settingController.setLineSpacing(value.round());
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
