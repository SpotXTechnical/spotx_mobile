import 'package:intl/intl.dart';

class AppDateFormatPatterns {
  AppDateFormatPatterns._();
  // 2021-02-07T23:55:07.010828Z
  static const String standard = 'yyyy-MM-ddThh:mm:ss.SSSSSSZ';
  static const String serverDateTime = 'yyyy-MM-ddThh:mm:ss.SSSSSS';
  static const String serverDateTime2 = 'yyyy-MM-ddTHH:mm:ss';
  static const String dayMonthYear = 'yyyy/MM/dd';
  static const String dayMonthYearServer = 'yyyy-MM-dd';
  static const String dayMonthYearSpaced = 'dd MMM yyyy';
  static const String dayMonthYearSpacedDay = 'EEEE dd MMM yyyy';
  static const String hoursMinsSecsSpaced = 'hh:mm a';
}

class AppDateFormats {

  AppDateFormats._();

  static DateFormat standard =
      DateFormat(AppDateFormatPatterns.standard, defaultDateFormatLocale, );

  static DateFormat dayMonthYear = DateFormat(AppDateFormatPatterns.dayMonthYear, defaultDateFormatLocale);
  static DateFormat dayMonthYearServer = DateFormat(AppDateFormatPatterns.dayMonthYearServer, defaultDateFormatLocale);
  static DateFormat serverDateTime = DateFormat(AppDateFormatPatterns.serverDateTime, defaultDateFormatLocale);
  static DateFormat serverDateTime2 = DateFormat(AppDateFormatPatterns.serverDateTime2, defaultDateFormatLocale);
  static DateFormat hoursMinsSecsSpaced = DateFormat(AppDateFormatPatterns.hoursMinsSecsSpaced, defaultDateFormatLocale);
}
const String defaultDateFormatLocale = 'en';
final defaultDateTime = DateTime(2023);