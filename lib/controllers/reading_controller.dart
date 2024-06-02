import 'package:novel_crawl/models/reading_model.dart';
import 'package:novel_crawl/service/api_service.dart';
import 'package:novel_crawl/service/file_service.dart';
import 'package:novel_crawl/service/history_service.dart';
import 'package:novel_crawl/service/state_service.dart';

class ReadingController {
  ReadingModel readingModel;

  ReadingController({required this.readingModel});

  FileService fileService = FileService.instance;
  StateService stateService = StateService.instance;

  void init(Function()? update) {
    stateService.getSources().then((value) {
      readingModel.sources = value;
      changeContentWhenChangeChapter(update);
    });
  }

  void updateState() {
    stateService.getSelectedSource().then((value) {
      readingModel.content = readingModel
          .allSourceChapterContent.chapterContents
          .where((element) => element.source == value)
          .first
          .content;
    });
  }

  void changeContentWhenChangeChapter(Function()? update){
    try {
      if (readingModel.isOffline) {
        fileService
            .getChapterContent(readingModel.novel, readingModel.chapter)
            .then((value) {
          readingModel.allSourceChapterContent = value;
          if (value.chapterContents.isEmpty) {
            throw Exception('Lỗi không thể tải nội dung chương truyện.');
          }
          selectContentFromPrioritySource(update);
          HistoryService.instance
              .updateNovelHistory(readingModel.novel, readingModel.chapter);
        });
      } else {
        APIService()
            .getChapterContent(readingModel.novel, readingModel.chapter)
            .then((value) {
          readingModel.allSourceChapterContent = value;
          if (value.chapterContents.isEmpty) {
            throw Exception('Lỗi không thể tải nội dung chương truyện.');
          }
          selectContentFromPrioritySource(update);
          HistoryService.instance
              .updateNovelHistory(readingModel.novel, readingModel.chapter);
        }).catchError((e) {
          readingModel.content =
              'Không thể tải nội dung chương truyện.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n';
        });
      }
    } catch (e) {
      throw Exception('Lỗi không thể tải nội dung chương truyện.');
    }
  }

  void selectContentFromPrioritySource(Function()? update){
    for (var source in readingModel.sources) {
      if (readingModel.allSourceChapterContent.chapterContents
          .where((element) => element.source == source)
          .isNotEmpty) {
        readingModel.content = readingModel
            .allSourceChapterContent.chapterContents
            .where((element) => element.source == source)
            .first
            .content;
        stateService.saveSelectedSource(source);
        update!();
        print('Selected source: $source');
        break;
      }
    }
  }

  void getNextChapter() {
    if (readingModel.isOffline) {
      fileService.getChapterList(readingModel.novel.novelName).then((value) {
        if (readingModel.chapter < int.parse(value.last)) {
          var nextchapterIndex =
              value.indexOf(readingModel.chapter.toString()) + 1;
          readingModel.chapter = int.parse(value[nextchapterIndex]);
        }
      });
    } else {
      if (readingModel.chapter < readingModel.novel.numberOfChapters) {
        readingModel.chapter++;
      }
    }
  }

  void getPreviousChapter() {
    if (readingModel.isOffline) {
      fileService.getChapterList(readingModel.novel.novelName).then((value) {
        if (readingModel.chapter > int.parse(value.first)) {
          var previousChapterIndex =
              value.indexOf(readingModel.chapter.toString()) - 1;
          readingModel.chapter = int.parse(value[previousChapterIndex]);
        }
      });
    } else {
      if (readingModel.chapter > 1) {
        readingModel.chapter--;
      }
    }
  }
}
