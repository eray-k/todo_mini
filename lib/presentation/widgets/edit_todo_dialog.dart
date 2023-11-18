import 'package:flutter/material.dart';
import '../../core/widget/dialog_buttons.dart';
import '../../data/models/todo.dart';

class EditTodoDialog extends StatefulWidget {
  const EditTodoDialog({
    super.key,
    required this.initialTodo,
  });
  final Todo initialTodo;
  @override
  State<StatefulWidget> createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  late final TextEditingController _controller;
  late Todo todo;
  @override
  void initState() {
    todo = widget.initialTodo;
    _controller = TextEditingController.fromValue(TextEditingValue(
      text: widget.initialTodo.content,
    ));
    _controller.addListener(() {
      setState(() {
        todo = todo.copyWith(content: _controller.text);
      });
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
                setState(() {
                  todo = todo.copyWith(isCompleted: !todo.isCompleted);
                });
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
