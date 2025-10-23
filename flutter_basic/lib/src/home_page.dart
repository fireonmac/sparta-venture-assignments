import 'package:flutter/material.dart';
import 'package:flutter_basic/src/constants.dart';
import 'package:flutter_basic/src/styles.dart';
import 'package:flutter_basic/src/todo_entity.dart';
import 'package:flutter_basic/src/todos_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final todosNotifier = TodosProvider.of(context);

    return ListenableBuilder(
      listenable: todosNotifier,
      builder: (context, child) {
        final todos = todosNotifier.todos;

        return Scaffold(
          appBar: AppBar(title: const Text(appTitle, style: Styles.title)),
          body: todos.isEmpty ? const _NoTasks() : _TasksList(todos: todos),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (BuildContext context) {
                  return const AddTaskForm();
                },
              );
            },
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 24),
          ),
        );
      },
    );
  }
}

class _TasksList extends StatelessWidget {
  final List<TodoEntity> todos;

  const _TasksList({required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return _TaskListItem(todo: todos[index]);
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: todos.length,
    );
  }
}

class _TaskListItem extends StatelessWidget {
  final TodoEntity todo;

  const _TaskListItem({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          if (todo.description != null && todo.description!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              todo.description!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NoTasks extends StatelessWidget {
  const _NoTasks();

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

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isFavorite = false;
  bool _showDescription = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void save() {
    final title = _titleController.text.trim();
    if (title.isNotEmpty) {
      final todosNotifier = TodosProvider.of(context);
      todosNotifier.add(
        title: title,
        description: _descriptionController.text,
        isFavorite: _isFavorite,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasTitle = _titleController.text.trim().isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => save(),
            decoration: const InputDecoration(
              hintText: "새 할 일",
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 16),
          ),
          if (_showDescription) ...[
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: "세부정보 추가",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 14),
              maxLines: null,
              minLines: 1,
              textInputAction: TextInputAction.newline,
            ),
          ],
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (!_showDescription)
                    IconButton(
                      icon: const Icon(Icons.short_text_rounded, size: 24),
                      onPressed: () {
                        setState(() {
                          _showDescription = true;
                        });
                      },
                    ),
                  IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.star : Icons.star_border,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                  ),
                ],
              ),
              TextButton(
                onPressed: hasTitle ? save : null,
                child: const Text("저장", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
