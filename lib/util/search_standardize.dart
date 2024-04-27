class SearchStandardize {
  static String standardize(String search) {
    search = search.replaceAll(RegExp(r' '), '+');
    return search;
  }
}
