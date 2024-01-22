class NameString {
  static String prefix = 'FCBCalc Key: ';
  static String regPrefix = 'FCBCalc: ';
}

String getTermString(int compounding) {
  if (compounding == 1) {
    return '(annually)';
  } else if (compounding == 2) {
    return '(semi-annually)';
  } else if (compounding == 4) {
    return '(quarterly)';
  } else if (compounding == 12) {
    return '(monthly)';
  } else {
    return '';
  }
}