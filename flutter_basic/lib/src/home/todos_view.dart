import 'package:flutter/material.dart';
import 'package:flutter_basic/src/constants.dart';
import 'package:flutter_basic/src/styles.dart';
import 'package:flutter_basic/src/todo_detail_page.dart';
import 'package:flutter_basic/src/todo_entity.dart';
import 'package:flutter_basic/src/todos_provider.dart';

class TodosView extends StatelessWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context) {
    final todosNotifier = TodosProvider.of(context);

    return ListenableBuilder(
      listenable: todosNotifier,
      builder: (context, child) {
        final todos = todosNotifier.todos;

        return todos.isEmpty
            ? const _NoTodosView()
            : _TodosListView(todos: todos);
      },
    );
  }
}

class _TodosListView extends StatelessWidget {
  final List<TodoEntity> todos;

  const _TodosListView({required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return _TodosListItemView(todo: todos[index], index: index);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: todos.length,
    );
  }
}

class _TodosListItemView extends StatelessWidget {
  final TodoEntity todo;
  final int index;

  const _TodosListItemView({required this.todo, required this.index});

  @override
  Widget build(BuildContext context) {
    final todosNotifier = TodosProvider.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            todo.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
          ),
          onPressed: () => todosNotifier.toggleIsDone(index),
        ),
        title: Text(todo.title),
        trailing: IconButton(
          icon: Icon(todo.isFavorite ? Icons.star : Icons.star_border),
          onPressed: () => todosNotifier.toggleIsFavorite(index),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TodoDetailPage(index: index),
            ),
          );
        },
      ),
    );
  }
}

class _NoTodosView extends StatelessWidget {
  const _NoTodosView();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: Styles.cardBorderRadius),
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              Image.asset('assets/images/empty.webp', width: 100),
              const Text(
                '아직 할 일이 없음',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Text(
                '할 일을 추가하고 $appTitle에 할 일을 추적하세요.',
                style: TextStyle(fontSize: 14, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
