import 'package:flutter/material.dart';
import 'package:flutter_basic/src/todos_provider.dart';

class AddTodoView extends StatefulWidget {
  const AddTodoView({super.key});

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
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
