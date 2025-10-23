import 'package:flutter/material.dart';
import 'package:flutter_basic/src/constants.dart';
import 'package:flutter_basic/src/home/todos_view.dart';
import 'package:flutter_basic/src/home_page.dart';
import 'package:flutter_basic/src/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text(appTitle, style: Styles.title)),
      body: Padding(
        padding: Styles.bodyPadding,
        child: const TodosView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (BuildContext context) {
              return const AddTaskView();
            },
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }
}
