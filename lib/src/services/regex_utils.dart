class RegexUtils {
  static RegExp numberRegExp = RegExp(r'\d+');
  static RegExp operatorRegExp = RegExp(r'[^\w\s^]');
  // Regular expression to match numbers and operators, also "() and %" symbols
  static RegExp digitsRegExp = RegExp(r'\d+((\.|,)\d*)?|[\+\-\*/\(\),%^]');
  static RegExp percentageRegExp = RegExp(r'(\d+(\.\d*)?)%');
}
