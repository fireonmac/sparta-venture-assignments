import 'package:flutter/material.dart';

Route<T> buildScreenRoute<T>(
  BuildContext context, {
  required Widget screen,
  bool fullscreenDialog = false,
  RouteSettings? settings,
}) {
  return MaterialPageRoute<T>(
    builder: (_) => screen,
    fullscreenDialog: fullscreenDialog,
    settings: settings,
  );
}