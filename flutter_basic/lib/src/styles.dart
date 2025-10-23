import 'package:flutter/material.dart';

abstract class Styles {
  // ************************************************
  // @ text
  // ************************************************
  static const bold = TextStyle(fontWeight: FontWeight.bold);
  static const title = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

  // ************************************************
  // @ padding
  // ************************************************
  static const bodyPadding = EdgeInsets.symmetric(
    vertical: 20.0,
    horizontal: 20.0,
  );

  // ************************************************
  // @ cards
  // ************************************************
  static const cardBorderRadius = BorderRadius.all(Radius.circular(12.0));

  // ************************************************
  // @ colors
  // ************************************************

  // primary: blue
  static const MaterialColor primaryColor =
      MaterialColor(_primaryPrimaryValue, <int, Color>{
        50: Color(0xFFE4EFF9),
        100: Color(0xFFBBD7F1),
        200: Color(0xFF8DBCE8),
        300: Color(0xFF5FA1DE),
        400: Color(0xFF3D8CD7),
        500: Color(_primaryPrimaryValue),
        600: Color(0xFF1870CB),
        700: Color(0xFF1465C4),
        800: Color(0xFF105BBE),
        900: Color(0xFF0848B3),
      });
  static const int _primaryPrimaryValue = 0xFF1B78D0;

  // secondary: green
  static const MaterialColor secondaryColor =
      MaterialColor(_secondaryPrimaryValue, <int, Color>{
        50: Color(0xFFECF3E5),
        100: Color(0xFFD0E0BD),
        200: Color(0xFFB1CC92),
        300: Color(0xFF91B866),
        400: Color(0xFF7AA845),
        500: Color(_secondaryPrimaryValue),
        600: Color(0xFF5A9120),
        700: Color(0xFF50861B),
        800: Color(0xFF467C16),
        900: Color(0xFF346B0D),
      });
  static const int _secondaryPrimaryValue = 0xFF629924;

  // accent: orange
  static const MaterialColor accentColor =
      MaterialColor(_accentPrimaryValue, <int, Color>{
        50: Color(0xFFFAEAE0),
        100: Color(0xFFF3CAB3),
        200: Color(0xFFEBA780),
        300: Color(0xFFE2844D),
        400: Color(0xFFDC6926),
        500: Color(_accentPrimaryValue),
        600: Color(0xFFD14800),
        700: Color(0xFFCC3F00),
        800: Color(0xFFC63600),
        900: Color(0xFFBC2600),
      });
  static const int _accentPrimaryValue = 0xFFD64F00;

  // danger: red
  static const MaterialColor errorColor =
      MaterialColor(_dangerPrimaryValue, <int, Color>{
        50: Color(0xFFFFEBEE),
        100: Color(0xFFFFCDD2),
        200: Color(0xFFEF9A9A),
        300: Color(0xFFE57373),
        400: Color(0xFFEF5350),
        500: Color(_dangerPrimaryValue),
        600: Color(0xFFE53935),
        700: Color(0xFFD32F2F),
        800: Color(0xFFC62828),
        900: Color(0xFFB71C1C),
      });
  static const int _dangerPrimaryValue = 0xFFF44336;
}
