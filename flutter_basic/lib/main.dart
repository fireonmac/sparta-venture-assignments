import 'package:flutter/material.dart';
import 'package:flutter_basic/src/constants.dart';
import 'package:flutter_basic/src/home/home_page.dart';
import 'package:flutter_basic/src/todos_provider.dart';
import 'package:flutter_basic/src/todos_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TodosNotifier _todosNotifier = TodosNotifier();

  @override
  Widget build(BuildContext context) {
    return TodosProvider(
      notifier: _todosNotifier,
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomePage(),
      ),
    );
  }
}
