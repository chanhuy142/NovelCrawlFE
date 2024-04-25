import 'dart:convert';

import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/service/hive_service.dart';

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

    Future updateNovelHistory(TruyenDetail truyenDetail, int currentChapter) async {
        var historyData = await getHistory();
        historyData[truyenDetail.tenTruyen] = {
            'novelDetail': truyenDetail.toJson(),
            'currentChapter': currentChapter.toString()
        };
        await setHistory(historyData);
    }

    Future deleteNovelHistory(String novelName) async {
        var historyData = await getHistory();
        historyData.remove(novelName);
        await setHistory(historyData);
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

    Future<List<TruyenDetail>> getHistoryList() async {
        var historyData = await getHistory();
        List<TruyenDetail> historyList = [];
        historyData.forEach((key, value) {
            historyList.add(TruyenDetail.fromJson(value['novelDetail']));
        });
        return historyList;
    }
    
    Future closeService() async {
        await hiveService.closeBox();
    }
}