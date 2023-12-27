import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import '../../data/local/shared_prefs_manager.dart';

const Color dark = Color(0xFF1d2229);
const Color ebonyClay = Color(0xff262d35);
const Color outerSpace = Color(0xFF2f3843);
const Color midNight = Color(0xff3e4d5d);

const Color pacificBlue = Color(0xFF42b9b4);
const Color blueDiamond = Color(0xFF53e1db);
const Color seaBlue = Color(0xFF0c648d);
const Color verdigris = Color(0xFF2396cc);
const Color jungleGreen = Color(0xFF279591);
Color lightShimmerBackground = Colors.grey.shade200;
Color lightShimmerBase = Colors.grey.shade300;
Color lightShimmerHighlight = Colors.grey.shade100;
const reservedGuestColor = Color(0xFF8C3131);

const Color dimGrey = Color(0xFF717171);
const Color kWhite = Color(0xffffffff);
const Color cadetGrey = Color(0xFF8f9bb3);
const Color lightSteelBlue = Color(0xffaac2da);
const Color lightBlue = Color(0xFFcfd5e5);
const Color white70 = Color(0xb3ffffff);
const Color darkShimmerBackground = outerSpace;
const Color darkShimmerBase = ebonyClay;
Color darkShimmerHighlight = midNight;

const Color imageErrorColor = Color(0xFFDCE0E9);

const Color mediumTurquoise = Color(0x1a53e1db);
const Color yellowOrange = Color(0xFFfdad3e);

class Fonts {
  static const CircularStd = 'CircularStd';
  static const ARIAL = 'Arial';
  static const HelveticaNeue = 'HelveticaNeue';
  static const HelveticaNeueMedium = 'HelveticaNeueMedium';
  static const avenirNext = 'Avenir-Next';
  static const montserrat = 'Montserrat';
  static const CircularStdBook = "CircularStd-Book";
  static const CircularStdMedium = 'CircularStd-Medium';
  static const Poppins = "Poppins";
}

final lightTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: Fonts.avenirNext,
    brightness: Brightness.dark,
    //Colors
    scaffoldBackgroundColor: kWhite,
    primaryColorDark: lightBlue,
    backgroundColor: lightSteelBlue,
    unselectedWidgetColor: cadetGrey,
    primaryColorLight: pacificBlue,
    canvasColor: jungleGreen,
    shadowColor: seaBlue,
    highlightColor: verdigris,
    secondaryHeaderColor: jungleGreen,
    disabledColor: dimGrey,
    cardColor: dark,
    dividerColor: ebonyClay,
    splashColor: outerSpace,
    hintColor: midNight,
    dialogBackgroundColor: ebonyClay,
    indicatorColor: mediumTurquoise,
    selectedRowColor: yellowOrange,
    hoverColor: lightShimmerBackground);

final darkTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: Fonts.avenirNext,
    brightness: Brightness.dark,
    //Colors
    scaffoldBackgroundColor: ebonyClay,
    primaryColorDark: dark,
    backgroundColor: outerSpace,
    unselectedWidgetColor: midNight,
    primaryColorLight: pacificBlue,
    canvasColor: blueDiamond,
    shadowColor: seaBlue,
    highlightColor: verdigris,
    secondaryHeaderColor: jungleGreen,
    disabledColor: dimGrey,
    cardColor: ebonyClay,
    dividerColor: cadetGrey,
    splashColor: lightSteelBlue,
    hintColor: lightBlue,
    dialogBackgroundColor: white70,
    indicatorColor: mediumTurquoise,
    selectedRowColor: yellowOrange,
    hoverColor: darkShimmerBackground,
);

TextStyle avenirNextRegular({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.avenirNext,
    fontWeight: FontWeight.w400,
  );
}

TextStyle avenirNextMedium({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.avenirNext,
    fontWeight: FontWeight.w500,
  );
}

TextStyle avenirNextSimiBold({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.avenirNext,
    fontWeight: FontWeight.w600,
  );
}

TextStyle avenirNextBold({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.avenirNext,
    fontWeight: FontWeight.w700,
  );
}

TextStyle helveticRegular({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.HelveticaNeue,
    fontWeight: FontWeight.normal,
  );
}

TextStyle helveticMedium({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.HelveticaNeue,
    fontWeight: FontWeight.w500,
  );
}

TextStyle helveticBold({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.HelveticaNeue,
    fontWeight: FontWeight.bold,
  );
}

TextStyle circularBold900({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.CircularStd,
    fontWeight: FontWeight.w900,
  );
}

TextStyle circularBold800({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.CircularStd,
    fontWeight: FontWeight.w800,
  );
}

TextStyle circularBold700({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.CircularStd,
    fontWeight: FontWeight.w700,
  );
}

TextStyle circularBook(
    {required Color color, required double fontSize, TextOverflow overflow = TextOverflow.ellipsis}) {
  return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: Fonts.CircularStdBook,
      fontWeight: FontWeight.w400,
      overflow: overflow);
}

TextStyle circularBookBold({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.CircularStdBook,
    fontWeight: FontWeight.w600,
  );
}

TextStyle circularMedium({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.CircularStd,
    fontWeight: FontWeight.normal,
  );
}

TextStyle poppinsThin({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.Poppins,
    fontWeight: FontWeight.w100,
  );
}

TextStyle poppinsExtraLight({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.Poppins,
    fontWeight: FontWeight.w200,
  );
}

TextStyle poppinsLight({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.Poppins,
    fontWeight: FontWeight.w300,
  );
}

TextStyle poppinsRegular({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.Poppins,
    fontWeight: FontWeight.w400,
  );
}

TextStyle poppinsMedium({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.Poppins,
    fontWeight: FontWeight.w500,
  );
}

TextStyle poppinsSemiBold({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.Poppins,
    fontWeight: FontWeight.w600,
  );
}

TextStyle poppinsBold({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.Poppins,
    fontWeight: FontWeight.w700,
  );
}

TextStyle poppinsExtraBold({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.Poppins,
    fontWeight: FontWeight.w800,
  );
}

const TextStyle errorTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 14,
);

const TextStyle underlineTextStyle = TextStyle(
  color: outerSpace,
  fontSize: 14,
  fontFamily: Fonts.ARIAL,
  decoration: TextDecoration.underline,
);

TextStyle montserratSemiBold({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.montserrat,
    fontWeight: FontWeight.w600,
  );
}

TextStyle circularBold({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.CircularStd,
    fontWeight: FontWeight.w900,
  );
}

TextStyle montserratBold({required Color color, required double fontSize}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: Fonts.montserrat,
    fontWeight: FontWeight.w700,
  );
}

ThemeData getLightTheme() {
  // make the light theme the default in case of there is no theme yet in sharedPreferance
  final SharedPrefsManager sharedPrefsManager =
      Injector().get<SharedPrefsManager>();
  String currentTheme = sharedPrefsManager.theme;
  if (currentTheme != "") {
    if (currentTheme == darkThemePref) {
      return darkTheme;
    }
  }
  return lightTheme;
}

ThemeData getDarkTheme() {
  // make the dark theme the default in case of there is no theme yet in sharedPreferance
  final SharedPrefsManager sharedPrefsManager =
      Injector().get<SharedPrefsManager>();
  String currentTheme = sharedPrefsManager.theme;
  if (currentTheme != "") {
    if (currentTheme == lightThemePref) {
      return lightTheme;
    }
  }
  return darkTheme;
}

ThemeData timePickerThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: seaBlue, onSurface: white70, onBackground: Colors.black),
      timePickerTheme: TimePickerTheme.of(context).copyWith(
        hourMinuteColor: dark,
        backgroundColor: ebonyClay,
      ));
}

ThemeData datePickerThemeData(BuildContext context) {
  return ThemeData.dark();
}

const lightThemePref = "lightThemePref";
const darkThemePref = "darkThemePref";