import 'package:flutter/material.dart';
import 'package:flutter_basic/src/constants.dart';
import 'package:flutter_basic/src/home/home_page.dart';
import 'package:flutter_basic/src/styles.dart';
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
          colorScheme: ColorScheme.fromSeed(
            seedColor: Styles.primaryColor,
            primary: Styles.primaryColor,
            secondary: Styles.secondaryColor,
            error: Styles.errorColor,
          ),
          primarySwatch: Styles.primaryColor,
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
