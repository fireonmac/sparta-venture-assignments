import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/auth/auth_notifier.dart';

class AuthContainer extends InheritedWidget {
  final AuthNotifier notifier;

  const AuthContainer({
    super.key,
    required this.notifier,
    required super.child,
  });

  static AuthNotifier of(BuildContext context) {
    final container = context.dependOnInheritedWidgetOfExactType<AuthContainer>();
    if (container == null) {
      throw Exception('AuthContainer not found');
    }
    return container.notifier;
  }

  @override
  bool updateShouldNotify(AuthContainer oldWidget) {
    return notifier != oldWidget.notifier;
  }
}
