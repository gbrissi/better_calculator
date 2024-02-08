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

  String removeCharAt(int index) {
    if (index < 0 || index >= length) {
      // Handle invalid index
      return this;
    }

    List<String> chars = split(''); // Convert string to list of characters
    chars.removeAt(index); // Remove character at the specified index
    return chars.join(''); // Convert list back to string
  }
}
