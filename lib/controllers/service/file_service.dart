import 'dart:convert';
import 'dart:io';

import 'package:novel_crawl/models/chapter_factory.dart';
import 'package:novel_crawl/models/novel.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  FileService._privateConstructor();
  static final FileService _instance = FileService._privateConstructor();
  static FileService get instance => _instance;
  final String imageFolder = 'NovelImage';
  final String novelFolder = 'NovelOffline';
  final String novelNameList = 'novelList';
  final String novelChapterList = 'chapterList';

  Future<void> init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory imageDir = Directory('${appDocDir.path}/$imageFolder');
    Directory novelDir = Directory('${appDocDir.path}/$novelFolder');
    if (!await imageDir.exists()) {
      await imageDir.create();
    }
    if (!await novelDir.exists()) {
      await novelDir.create();
      File('${novelDir.path}/$novelNameList').create();
    } else {
      if (!await File('${novelDir.path}/$novelNameList').exists()) {
        File('${novelDir.path}/$novelNameList').create();
      }
    }
  }

  Future<void> saveNovelImage(String novelName, String imageUrl) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory imageDir = Directory('${appDocDir.path}/$imageFolder');
    if (!await imageDir.exists()) {
      await imageDir.create();
    }
    final response = await HttpClient().getUrl(Uri.parse(imageUrl));
    final image = await response.close();

    File imageFile = File('${imageDir.path}/$novelName.jpg');
    await image.pipe(imageFile.openWrite());
  }

  Future<File?> getNovelImage(String novelName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory imageDir = Directory('${appDocDir.path}/$imageFolder');
    if (!await imageDir.exists()) {
      await imageDir.create();
    }
    File imageFile = File('${imageDir.path}/$novelName.jpg');
    if (!await imageFile.exists()) {
      return null;
    }
    return imageFile;
  }

  Future<bool> checkNovelExist(String novelName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory novelDir = Directory('${appDocDir.path}/$novelFolder');
    if (!await novelDir.exists()) {
      await novelDir.create();
    }
    File novelListFile = File('${novelDir.path}/$novelNameList');
    if (!await novelListFile.exists()) {
      await novelListFile.create();
    }
    Directory novelNameDir = Directory('${novelDir.path}/$novelName');
    if (!await novelNameDir.exists()) {
      return false;
    }
    return true;
  }

  Future<void> addANovelDetail(Novel novelDetail) async {
    if (await checkNovelExist(novelDetail.name)) {
      print('Novel already exist');
      return;
    }
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory novelDir = Directory('${appDocDir.path}/$novelFolder');
    if (!await novelDir.exists()) {
      await novelDir.create();
    }
    File novelListFile = File('${novelDir.path}/$novelNameList');
    if (!await novelListFile.exists()) {
      await novelListFile.create();
    }
    Directory novelNameDir = Directory('${novelDir.path}/${novelDetail.name}');
    if (!await novelNameDir.exists()) {
      await novelNameDir.create();
    }
    String newOfflineNovel = '${jsonEncode(novelDetail.toJson())}\n';
    await novelListFile.writeAsString(newOfflineNovel, mode: FileMode.append);
  }

  Future<List<Novel>> getNovelList() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory novelDir = Directory('${appDocDir.path}/$novelFolder');
    if (!await novelDir.exists()) {
      await novelDir.create();
    }
    File novelListFile = File('${novelDir.path}/$novelNameList');
    if (!await novelListFile.exists()) {
      await novelListFile.create();
    }
    List<Novel> novelList = [];
    List<String> novelListString = await novelListFile.readAsLines();
    for (String novelString in novelListString) {
      novelList.add(Novel.fromJson(jsonDecode(novelString)));
    }
    return novelList;
  }

  Future<void> saveChapter(String novelName, String chapterName,
      ChapterFactory allSourceChapterContent) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory novelDir = Directory('${appDocDir.path}/$novelFolder');
    if (!await novelDir.exists()) {
      await novelDir.create();
    }
    File chapterFile = File('${novelDir.path}/$novelName/$chapterName');
    if (!await chapterFile.exists()) {
      await chapterFile.create();
      File chapterListFile =
          File('${novelDir.path}/$novelName/$novelChapterList');
      if (!await chapterListFile.exists()) {
        await chapterListFile.create();
      }
      await chapterListFile.writeAsString('$chapterName\n',
          mode: FileMode.append);
    }
    await chapterFile
        .writeAsString(jsonEncode(allSourceChapterContent.toJson()));
  }

  Future<List<String>> getChapterList(String novelName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory novelDir = Directory('${appDocDir.path}/$novelFolder');
    if (!await novelDir.exists()) {
      await novelDir.create();
    }
    File chapterListFile =
        File('${novelDir.path}/$novelName/$novelChapterList');
    if (!await chapterListFile.exists()) {
      await chapterListFile.create();
    }
    List<String> chapterList = await chapterListFile.readAsLines();
    //sort chapterList in ascending order
    chapterList.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    return chapterList;
  }

  Future<ChapterFactory> getChapterContent(Novel novel, int chapter) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory novelDir = Directory('${appDocDir.path}/$novelFolder');
    if (!await novelDir.exists()) {
      await novelDir.create();
    }
    File chapterFile = File('${novelDir.path}/${novel.name}/$chapter');
    if (!await chapterFile.exists()) {
      await chapterFile.create();
    }
    return ChapterFactory.fromJson(
        jsonDecode(await chapterFile.readAsString()));
  }

  Future<bool> deleteNovel(String name) async {
    //delete folder
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      Directory novelDir = Directory('${appDocDir.path}/$novelFolder/$name');
      if (novelDir.existsSync()) {
        novelDir.deleteSync(recursive: true);
      }
      //delete from novelList
      List<Novel> novelList = await getNovelList();
      novelList.removeWhere((element) => element.name == name);
      File novelListFile = File('${appDocDir.path}/$novelFolder/$novelNameList');
      await novelListFile.writeAsString('');
      for (Novel novel in novelList) {
        await novelListFile.writeAsString('${jsonEncode(novel.toJson())}\n',
            mode: FileMode.append);
      }

      


      return true;
    } catch (e) {
      return false;
    }
  }
}
