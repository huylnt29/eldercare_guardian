extension StringX on String {
  bool get isLocalFilePath {
    return !contains('http');
  }

  DateTime get toDateTime {
    return DateTime.parse(this);
  }
}
