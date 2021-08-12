import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ThemeColors {
  const ThemeColors();

  // static const Color loginGradientStart = const Color(0xFFfbab66);
  // static const Color loginGradientEnd = const Color(0xFFf7418c);

  static const Color loginGradientStart = const Color(0xFF03161d);
  static const Color loginGradientEnd = const Color(0xFF03161d);
  static const Color loginGradientEnd2 = const Color(0xFF2C3539);

  static const primaryGradient = const LinearGradient(
    colors: const [
      loginGradientStart,
      loginGradientEnd,
      loginGradientEnd2,
    ],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
