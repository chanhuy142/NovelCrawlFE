import 'dart:ui';

class SettingModel{
  int fontId = 0;
  int colorId = 0;
  int backgroundId = 0;
  int fontSize = 16;
  int lineSpacing = 1;

  Color color = const Color(0xFFFFFFFF);
  Color background = const Color(0xFF000000);
  String font = "Roboto";
  List<Color> colors = [];
  List<String> fonts = [];
}