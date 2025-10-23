import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_basic/src/todo_entity.dart';

class TodosNotifier with ChangeNotifier {
  final List<TodoEntity> _todos = [
    TodoEntity(title: '안녕', isFavorite: false, isDone: false)
  ];

  UnmodifiableListView<TodoEntity> get todos => UnmodifiableListView(_todos);

  void add({required String title, String? description, bool isFavorite = false}) {
    if (title.isNotEmpty) {
      _todos.add(
        TodoEntity(
          title: title,
          description: description,
          isFavorite: isFavorite,
          isDone: false,
        ),
      );
    }

    notifyListeners();
  }

  void toggleIsDone(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    notifyListeners();
  }

  void toggleIsFavorite(int index) {
    _todos[index].isFavorite = !_todos[index].isFavorite;
    notifyListeners();
  }

  void remove(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
