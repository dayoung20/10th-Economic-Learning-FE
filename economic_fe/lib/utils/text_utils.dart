// 한글 단어 단위 줄바꿈

String addZeroWidthJoiner(String text) {
  return text.replaceAllMapped(
    RegExp(r'(\S)(?=\S)'),
        (m) => '${m[1]}\u200D',
  );
}
