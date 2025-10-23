import 'package:flutter/material.dart';
import 'package:flutter_basic/src/styles.dart';
import 'package:flutter_basic/src/todos_provider.dart';

class TodoDetailPage extends StatefulWidget {
  final int index;
  const TodoDetailPage({super.key, required this.index});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  final _descriptionController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_descriptionController.text.isEmpty) {
      final todosNotifier = TodosProvider.of(context);
      final todo = todosNotifier.todos[widget.index];
      _descriptionController.text = todo.description ?? '';
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateDescription() {
    final todosNotifier = TodosProvider.of(context);
    todosNotifier.updateDescription(widget.index, _descriptionController.text);
  }

  @override
  Widget build(BuildContext context) {
    final todosNotifier = TodosProvider.of(context);

    return ListenableBuilder(
      listenable: todosNotifier,
      builder: (context, child) {
        final todo = todosNotifier.todos[widget.index];
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: Icon(todo.isFavorite ? Icons.star : Icons.star_border),
                  onPressed: () {
                    todosNotifier.toggleIsFavorite(widget.index);
                  },
                ),
              ),
            ],
          ),
          body: Padding(
            padding: Styles.bodyPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.short_text_rounded),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2),
                          Text('세부 내용은 다음과 같습니다.'),
                          SizedBox(height: 30),
                          TextField(
                            controller: _descriptionController,
                            maxLines: null,
                            minLines: 3,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                              hintText: '세부 내용은 여기에 작성합니다.',
                              border: InputBorder.none,
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (value) {
                              _updateDescription();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
