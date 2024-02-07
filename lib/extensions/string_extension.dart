extension StringExtension on String {
  int countOccurrences(String charToCount) {
    int count = 0;

    for (int i = 0; i < length; i++) {
      if (this[i] == charToCount) {
        count++;
      }
    }

    return count;
  }

  String insertCharAtPosition(String charToAdd, int position) {
    if (position < 0 || position > length) {
      throw ArgumentError('Position is out of range');
    }

    String firstPart = substring(0, position);
    String secondPart = substring(position);

    return firstPart + charToAdd + secondPart;
  }
}
