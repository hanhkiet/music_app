import 'package:flutter/material.dart';

class AppTheme {
  final Color bg1 = const Color(0xfff3f3f3);
  final Color surface1 = Colors.white;
  final Color surface2 = const Color(0xffebf0f3);
  final Color accent1 = const Color(0xff00ADB5);
  final Color greyWeak = const Color(0xffcccccc);
  final Color grey = const Color(0xff999999);
  final Color greyMedium = const Color(0xff747474);
  final Color greyStrong = const Color(0xff333333);
  final Color focus = const Color(0xffd81e1e);

  final bool isDark;

  late Color mainTextColor;
  late Color inverseTextColor;

  AppTheme({required this.isDark}) {
    mainTextColor = isDark ? Colors.white : Colors.black;
    inverseTextColor = isDark ? Colors.black : Colors.white;
  }

  ThemeData toThemeData() {
    var data = ThemeData.from(
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      colorScheme: ColorScheme(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primary: accent1,
          primaryContainer: shift(accent1, .1),
          secondary: accent1,
          secondaryContainer: shift(accent1, .1),
          background: bg1,
          surface: surface1,
          onBackground: mainTextColor,
          onSurface: mainTextColor,
          onError: mainTextColor,
          onPrimary: inverseTextColor,
          onSecondary: inverseTextColor,
          error: focus),
    );

    return data;
  }

  Color shift(Color c, double amt) {
    amt *= (isDark ? -1 : 1);
    var hslc = HSLColor.fromColor(c); // Convert to HSL
    double lightness =
        (hslc.lightness + amt).clamp(0, 1.0) as double; // Add/Remove lightness
    return hslc.withLightness(lightness).toColor(); // Convert back to Color
  }
}
