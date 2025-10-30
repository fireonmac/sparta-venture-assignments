import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/auth/auth_container.dart';

class AuthGuard extends StatelessWidget {
  final Widget onAuthFailure;
  final Widget onAuthSuccess;
  final Widget? onLoading;

  const AuthGuard({
    super.key,
    required this.onAuthFailure,
    required this.onAuthSuccess,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    final authNotifier = AuthContainer.of(context);

    return ListenableBuilder(
      listenable: authNotifier,
      builder: (context, child) {
        if (authNotifier.isInitialized) {
          return authNotifier.isLoggedIn ? onAuthSuccess : onAuthFailure;
        }
        return onLoading ??
            const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
