import 'package:flutter/material.dart';

abstract class Styles {
  // text
  static const bold = TextStyle(fontWeight: FontWeight.bold);
  static const title = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

  // padding
  static const bodyPadding = EdgeInsets.symmetric(
    vertical: 20.0,
    horizontal: 20.0,
  );

  // cards
  static const cardBorderRadius = BorderRadius.all(Radius.circular(12.0));
}
