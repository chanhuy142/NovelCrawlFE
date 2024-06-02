import 'package:novel_crawl/models/setting_model.dart';
import 'package:novel_crawl/service/state_service.dart';

class SettingController {
  SettingModel setting;
  SettingController._privateConstructor() : setting = SettingModel();
  static final SettingController _instance = SettingController._privateConstructor();
  static SettingController get instance => _instance;

  StateService stateService = StateService.instance;
  void init(){
    setting.colors = stateService.getColorList();
    setting.fonts = stateService.getFontFamilyList();
    stateService.getFontSize().then((value) {
        setting.fontSize = value;
    });

    stateService.getLineSpacing().then((value) {
        setting.lineSpacing = value;
    });

    stateService.getFontFamilyID().then((value) {
        setting.fontId = value;
    });

    stateService.getColorID().then((value) {
        setting.colorId = value;
    });

    stateService.getBackgroundColorID().then((value) {
        setting.backgroundId = value;
    });

    stateService.getBackgroundColor().then((value) {
        setting.background = value;
    });

    stateService.getColor().then((value) {
        setting.color = value;
    });

    stateService.getFontFamily().then((value) {
        setting.font = value;
    });
  }

  void setFontSize(int value) {
    stateService.saveFontSize(value);
    setting.fontSize = value;
  }

  void setLineSpacing(int value) {
    stateService.saveLineSpacing(value);
    setting.lineSpacing = value;
  }

  void setFontFamilyId(int value) {
    stateService.saveFontFamilyID(value);
    setting.fontId = value;
    setting.font = setting.fonts[value];
  }

  void setColorId(int value) {
    stateService.saveColorID(value);
    setting.colorId = value;
    setting.color = setting.colors[value];
  }

  void setBackgroundColorId(int value) {
    stateService.saveBackgroundColorID(value);
    setting.backgroundId = value;
    setting.background = setting.colors[value];
  }

  void dispose() {
    stateService.closeService();
  }
}
