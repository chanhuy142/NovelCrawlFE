import 'package:flutter/material.dart';
import 'package:novel_crawl/controllers/setting_controller.dart';

class FontFamilySettingSection extends StatelessWidget {
  const FontFamilySettingSection({
    super.key,
    required this.settingController,
    required this.onUpdated,
  });

  final SettingController settingController;
  final Function() onUpdated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      settingController.setFontFamilyId(index);
                      onUpdated();
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
                              color: index ==
                                      settingController
                                          .setting.fontId
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
                                  settingController
                                      .setting.fonts[index],
                                  style: TextStyle(
                                      color: index ==
                                              settingController
                                                  .setting.fontId
                                          ? const Color(
                                              0xFFDFD82C)
                                          : const Color(
                                              0xFFFFFFFF),
                                      fontSize: 20,
                                      fontWeight:
                                          FontWeight.normal,
                                      fontFamily:
                                          settingController
                                              .setting
                                              .fonts[index]),
                                ),
                                const Spacer(),
                                Visibility(
                                  visible: index ==
                                      settingController
                                          .setting.fontId,
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
    );
  }
}
