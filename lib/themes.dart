import 'package:flutter/material.dart';

class AppTheme {
  static const Color bg1 = Color(0xfff3f3f3);
  static const Color surface1 = Colors.white;
  static const Color surface2 = Color(0xffebf0f3);
  static const Color accent = Color.fromARGB(255, 0, 142, 149);
  static const Color greyWeak = Color(0xffcccccc);
  static const Color grey = Color(0xff999999);
  static const Color greyMedium = Color(0xff747474);
  static const Color greyStrong = Color(0xff333333);
  static const Color focus = Color(0xffd81e1e);

  static LinearGradient gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color.fromARGB(255, 0, 100, 105).withOpacity(0.2),
      accent.withOpacity(0.8),
    ],
  );

  static const Icon playingIcon = Icon(Icons.play_arrow_rounded);
  static const Icon pauseIcon = Icon(Icons.pause_rounded);
}
