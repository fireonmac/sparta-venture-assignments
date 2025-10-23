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

  @override
  Widget build(BuildContext context) {
    final todosNotifier = TodosProvider.of(context);

    return ListenableBuilder(
      listenable: todosNotifier,
      builder: (context, child) {
        if (widget.index >= todosNotifier.todos.length) {
          // 유효하지 않은 인덱스면 빈 Scaffold 반환
          return const Scaffold(body: Center(child: Text('할 일을 찾을 수 없습니다.')));
        }

        final todo = todosNotifier.todos[widget.index];
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(todo.isFavorite ? Icons.star : Icons.star_border),
                onPressed: () {
                  todosNotifier.toggleIsFavorite(widget.index);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: const Icon(Icons.delete_forever_outlined),
                  onPressed: () => _showDeleteDialog(context),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: Styles.bodyPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.title, style: Styles.title),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.short_text_rounded),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 2),
                          Text('세부 내용은 다음과 같습니다.'),
                          const SizedBox(height: 30),
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

  void _updateDescription() {
    final todosNotifier = TodosProvider.of(context);
    todosNotifier.updateDescription(widget.index, _descriptionController.text);
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('할 일 삭제'),
          content: const Text('정말로 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                await Navigator.of(
                  context,
                ).maybePop(); // TodoDetailPage 애니메이션 완료까지 대기
                // 페이지가 완전히 닫힌 후 삭제 실행
                if (context.mounted) {
                  final todosNotifier = TodosProvider.of(context);
                  todosNotifier.remove(widget.index);
                }
              },
              child: const Text('삭제', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
