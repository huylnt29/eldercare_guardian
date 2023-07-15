typedef Email = String;

extension EmailValication on Email {
  bool isValid() {
    if (contains('@')) {
      return true;
    } else {
      return false;
    }
  }

  bool isExisted() {
    return true;
  }
}
