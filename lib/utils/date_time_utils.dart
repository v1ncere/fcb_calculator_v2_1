import 'package:intl/intl.dart';

// convert DateTime into readable format [mmm dd, yyyy] only
String getDateString(DateTime date) {
  switch(date.month) {
    case 1:
      return "Jan ${date.day}, ${date.year}";
    case 2:
      return "Feb ${date.day}, ${date.year}";
    case 3:
      return "Mar ${date.day}, ${date.year}";
    case 4:
      return "Apr ${date.day}, ${date.year}";
    case 5:
      return "May ${date.day}, ${date.year}";
    case 6:
      return "Jun ${date.day}, ${date.year}";
    case 7:
      return "Jul ${date.day}, ${date.year}";
    case 8:
      return "Aug ${date.day}, ${date.year}";
    case 9:
      return "Sep ${date.day}, ${date.year}";
    case 10:
      return "Oct ${date.day}, ${date.year}";
    case 11:
      return "Nov ${date.day}, ${date.year}";
    case 12:
      return "Dec ${date.day}, ${date.year}";
    default:
      return '';
  }
}

class DateStrings {
  static const String minDateTime = '2010-04-11';
  static const String maxDateTime = '2200-04-11';
  static const String pickerFormat = 'yyyy-MMMM-dd';
  static const String dateFormat = 'yyyy-MM-dd';
}

class Date {
  // bayanihan date
  static DateTime byhn_1 = DateFormat(DateStrings.dateFormat).parse('2020-04-01');
  static DateTime byhn_2 = DateFormat(DateStrings.dateFormat).parse('2020-05-01');
  static DateTime byhn_3 = DateFormat(DateStrings.dateFormat).parse('2020-10-01');
  static DateTime byhn_4 = DateFormat(DateStrings.dateFormat).parse('2020-11-01');
  static DateTime byhnEnd = DateFormat(DateStrings.dateFormat).parse('2020-11-30');
}

DateTime? getMillis(int? intDate) {
  return intDate != null && intDate <= 9999999999999
  ? DateTime.fromMillisecondsSinceEpoch(intDate)
  : null;
}