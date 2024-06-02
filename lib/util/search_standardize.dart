import 'package:novel_crawl/util/signedtounsigned.dart';

class SearchStandardize {
  static String standardize(String search) {
    search = SignedToUnsinged.standardizeName(search);
    search = search.replaceAll(RegExp(r'-'), '+');
    return search;
  }
}
