import 'package:flutter/material.dart';
import 'package:novel_crawl/controllers/setting_controller.dart';

class ColorSettingSection extends StatelessWidget {
  const ColorSettingSection({
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
                        settingController.setBackgroundColorId(index);
                        settingController.setColorId(3 - index);
                        onUpdated();
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
    );
  }
}

