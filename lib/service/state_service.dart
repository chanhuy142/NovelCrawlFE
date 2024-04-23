import 'dart:async';

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
  StateService._privateConstructor(); 
  static final StateService _instance = StateService._privateConstructor();
  static StateService get instance => _instance;

  final List<Color> colors = [
    Colors.black,
    Colors.white,
    const Color(0xFF3A3E48),
    const Color(0xFFFFF1C2),
  ];

  final List<String> fonts = [
    'Roboto',
    'Open Sans',
    'Lora',
    'Merriweather',
    'Dancing Script',
  ];

  List<String> getFontFamilyList() {
    return fonts;
  }

  List<Color> getColorList() {
    return colors;
  }

  Future<int> getFontSize() async {
    return await hiveService.get(fontSize) ?? 16;
  }

  Future<int> getLineSpacing() async {
    return await hiveService.get(lineSpacing) ?? 1;
  }

  Future<int> getFontFamilyID() async {
    return await hiveService.get(fontFamily) ?? 0;
  }

  Future<int> getColorID() async {
    return await hiveService.get(color) ?? 0;
  }

  Future<String> getFontFamily() async {
    return fonts[await getFontFamilyID()];
  }

  Future<Color> getColor() async {
    return colors[await getColorID()];
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

  Future closeService() async {
    await hiveService.closeBox();
  }
}