import 'dart:async';

import 'api_service.dart';
import 'hive_service.dart';
import 'package:flutter/material.dart';


class StateService{
  final HiveService hiveService = HiveService.instance;
  final String fontSize = 'fontSize';
  final String lineSpacing = 'lineSpacing';
  final String fontFamily = 'fontFamily';
  final String color = 'fontColor';
  final String sources = 'sources';
  final String selectedSource = 'selectedSource';
  final String backgroundColor = 'backgroundColor';
  StateService._privateConstructor(); 
  static final StateService _instance = StateService._privateConstructor();
  static StateService get instance => _instance;

  final List<Color> colors = [
    Colors.black,
    const Color(0xFF3A3E48),
    const Color(0xFFFFF1C2),
    Colors.white,
  ];

  final List<String> fonts = [
    'Roboto',
    'Open Sans',
    'Lora',
    'Merriweather',
    'Dancing Script',
    'Montserrat',
    'Exo2',
    'Bitter'
  ];

  List<String> getFontFamilyList() {
    return fonts;
  }

  List<Color> getColorList() {
    return colors;
  }

  Future<int> getFontSize() async {
    return await hiveService.get(fontSize) ?? 25;
  }

  Future<int> getLineSpacing() async {
    return await hiveService.get(lineSpacing) ?? 2;
  }

  Future<int> getFontFamilyID() async {
    return await hiveService.get(fontFamily) ?? 3;
  }

  Future<int> getColorID() async {
    return await hiveService.get(color) ?? 2;
  }

  Future<int> getBackgroundColorID() async {
    return await hiveService.get(backgroundColor) ?? 1;
  }

  Future<String> getFontFamily() async {
    return fonts[await getFontFamilyID()];
  }

  Future<Color> getColor() async {
    return colors[await getColorID()];
  }

  Future<Color> getBackgroundColor() async {
    return colors[await getBackgroundColorID()];
  }

  Future<List<String>> getSources() async{
    return await hiveService.get(sources) ?? [];
  }

  Future<String> getSelectedSource() async {
    return await hiveService.get(selectedSource) ?? '';
  }

  Future saveSelectedSource(String value) async {
    await hiveService.put(selectedSource, value);
  }

  Future saveSources(List<String> value) async {
    await hiveService.put(sources, value);
  }

  Future saveFontSize(int value) async {
    await hiveService.put(fontSize, value);
  }

  Future saveLineSpacing(int value) async {
    await hiveService.put(lineSpacing, value);
  }

  Future saveFontFamilyID(int value) async {
    await hiveService.put(fontFamily, value);
  }

  Future saveColorID(int value) async {
    await hiveService.put(color, value);
  }

  Future saveBackgroundColorID(int value) async {
    await hiveService.put(backgroundColor, value);
  }

  Future closeService() async {
    await hiveService.closeBox();
  }

  Future checkSourcesInDB() async {
    List<String> novelSourcesDB = await getSources();
    List<String> novelSourcesAPI = await APIService().getAllSources();
    bool isDifferent = false;
    if (novelSourcesDB.length != novelSourcesAPI.length) {
      isDifferent = true;
    } else {
      for (int i = 0; i < novelSourcesDB.length; i++) {
        if (!novelSourcesDB.contains(novelSourcesAPI[i]) ||
            !novelSourcesAPI.contains(novelSourcesDB[i])) {
          isDifferent = true;
          break;
        }
      }
    }
    if (isDifferent) {
      novelSourcesDB = novelSourcesAPI;
      saveSources(novelSourcesDB);
    }
  }
}