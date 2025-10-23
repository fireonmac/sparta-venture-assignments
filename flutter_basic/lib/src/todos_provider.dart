import 'package:flutter/widgets.dart';
import 'package:flutter_basic/src/todos_notifier.dart';

class TodosProvider extends InheritedWidget {
  final TodosNotifier notifier;

  const TodosProvider({
    super.key,
    required this.notifier,
    required super.child,
  });

  @override
  bool updateShouldNotify(TodosProvider oldWidget) {
    return oldWidget.notifier != notifier;
  }

  static TodosNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TodosProvider>()!
        .notifier;
  }
}
