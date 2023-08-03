extension FilePath on String {
  bool get isLocalFilePath {
    return !contains('http');
  }
}
