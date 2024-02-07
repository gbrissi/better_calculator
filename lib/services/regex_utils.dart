class RegexUtils {
  static RegExp numberRegExp = RegExp(r'\d+');
  static RegExp operatorRegExp = RegExp(r'[^\w\s]');
  // Regular expression to match numbers and opeartors
  static RegExp digitsRegExp = RegExp(r'\d+((\.|,)\d*)?|[\+\-\*/\(\),]');
}
