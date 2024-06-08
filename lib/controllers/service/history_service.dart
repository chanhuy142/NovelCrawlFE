import 'dart:async';
import 'dart:convert';

import 'package:novel_crawl/models/novel.dart';
import 'package:novel_crawl/controllers/service/hive_service.dart';

class HistoryService{
    final HiveService hiveService = HiveService.instance;
    final String history = 'history';
    HistoryService._privateConstructor();
    static final HistoryService _instance = HistoryService._privateConstructor();
    static HistoryService get instance => _instance;

    Future<Map<String, dynamic>> getHistory() async {
        String jsonString = await hiveService.get(history)?? "";
        if (jsonString != "") {
            return jsonDecode(jsonString);
        } else {
            return <String, dynamic>{};
        }
    }

    Future<void> setHistory(Map<String, dynamic> historyData) async {
        await hiveService.put(history, jsonEncode(historyData));
    }

    Future updateNovelHistory(Novel novelDetail, int currentChapter) async {
        var historyData = await getHistory();
        Set<int> readChapters = await getReadChapters(novelDetail.name);
        readChapters.add(currentChapter);
        historyData[novelDetail.name] = {
            'novelDetail': novelDetail.toJson(),
            'currentChapter': currentChapter.toString(),
            'readChapters': jsonEncode(readChapters.toList())
        };
        await setHistory(historyData);
    }

    Future deleteNovelHistory(String novelName) async {
        var historyData = await getHistory();
        historyData.remove(novelName);
        await setHistory(historyData);
    }

    Future<Set<int>> getReadChapters(String novelName) async {
        var historyData = await getHistory();
        if(historyData.containsKey(novelName) == false) {
            return <int>{};
        }
        return Set<int>.from(jsonDecode(historyData[novelName]['readChapters'] ?? '[]'));
    }

    Future<int> getCurrentChapter (String novelName) async {
        print(novelName);
        var historyData = await getHistory();
       
        if(historyData.containsKey(novelName) == false) {
            return 1;
        }
        print(historyData[novelName]['currentChapter']);
        return int.parse(historyData[novelName]['currentChapter'] ?? '1');
    }

    Future<List<Novel>> getHistoryList() async {
        var historyData = await getHistory();
        List<Novel> historyList = [];
        historyData.forEach((key, value) {
            historyList.add(Novel.fromJson(value['novelDetail']));
        });
        return historyList;
    }

    Future<bool> isReadChapter(String novelName, int chapterNumber) async {
        return await getReadChapters(novelName).then((value) => value.contains(chapterNumber));
    }
    
    Future closeService() async {
        await hiveService.closeBox();
    }
}