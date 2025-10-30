import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/features/auth/auth_container.dart';
import 'package:flutter_basic_venture/src/styles.dart';

class MyProfileTab extends StatelessWidget {
  const MyProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = AuthContainer.of(context);
    final user = authNotifier.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 프로필', style: Styles.title),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authNotifier.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user?.photoURL != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
                radius: 40,
              ),
            const SizedBox(height: 8),
            Text(user?.displayName ?? '이름 없음'),
            Text(user?.email ?? '이메일 없음'),
          ],
        ),
      ),
    );
  }
}
