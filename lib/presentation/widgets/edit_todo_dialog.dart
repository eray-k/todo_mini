import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widget/dialog_buttons.dart';
import '../../data/models/todo.dart';
import '../controllers/edit_todo_provider.dart';

class EditTodoDialog extends ConsumerStatefulWidget {
  const EditTodoDialog({
    super.key,
    required this.initialTodo,
  });
  final Todo initialTodo;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends ConsumerState<EditTodoDialog> {
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController.fromValue(TextEditingValue(
      text: widget.initialTodo.content,
    ));
    _controller.addListener(() {
      ref.read(editedTodoNotifierProvider.notifier).state = ref
          .read(editedTodoNotifierProvider.notifier)
          .state
          .copyWith(content: _controller.text);
    });
    Future(() {
      ref.read(editedTodoNotifierProvider.notifier).state = widget.initialTodo;
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Todo todo = ref.watch(editedTodoNotifierProvider);
    print("edited todo: $todo");
    return AlertDialog.adaptive(
      title: const Text("Edit Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            controller: _controller,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                ref.read(editedTodoNotifierProvider.notifier).state =
                    todo.copyWith(isCompleted: !todo.isCompleted);
              },
              child: Row(
                children: [
                  //Theme.of(context).primaryColor),
                  Checkbox.adaptive(
                    fillColor: MaterialStateColor.resolveWith((states) {
                      return states.contains(MaterialState.selected)
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent;
                    }),
                    checkColor: Theme.of(context).colorScheme.onPrimary,
                    value: todo.isCompleted,
                    onChanged: null,
                  ),

                  const Text("Completed"),
                ],
              ),
            ),
          )
        ],
      ),
      actions: [
        _deleteItem(),
        cancelButton(context), // Pass todo as backup
        okButton(context, todo),
      ],
    );
  }

  TextButton _deleteItem() => TextButton(
      onPressed: () {
        //Deleted
      },
      child: const Text("Delete"));
}
