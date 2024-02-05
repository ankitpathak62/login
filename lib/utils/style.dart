import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils.dart';

class Style {
  static const _pageTransitionTheme = PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  });

  static final ThemeData light = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light().copyWith(
        primary: lightPrimaryColor,
      ),
      primaryColor: lightPrimaryColor,
      pageTransitionsTheme: _pageTransitionTheme,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme));

  static final ThemeData dark = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: darkPrimaryColor,
      ),
      primaryColor: darkPrimaryColor,
      pageTransitionsTheme: _pageTransitionTheme,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme));

  void lightOverlay(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
  }

  void darkOverlay(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(255, 49, 49, 49),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light));
  }
}
