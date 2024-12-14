int getStringCount(String text) {
  int firstIndex = text.indexOf(RegExp(r'[.!?]'));

  if (firstIndex != -1) {
    return firstIndex;
  } else {
    return text.length;
  }
}
