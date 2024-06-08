import 'package:novel_crawl/controllers/util/signed_to_unsigned.dart';

class SearchStandardize {
  static String standardize(String search) {
    search = SignedToUnsinged.standardizeName(search);
    search = search.replaceAll(RegExp(r'-'), '+');
    return search;
  }
}
