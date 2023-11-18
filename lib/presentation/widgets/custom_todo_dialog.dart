import 'package:flutter/material.dart';
import '../../core/widget/dialog_buttons.dart';
import '../../data/models/todo.dart';

class CustomTodoDialog extends StatefulWidget {
  const CustomTodoDialog({
    super.key,
    required this.initialTodo,
    required this.title,
    required this.hasDeleteButton,
  });
  final Todo initialTodo;
  final String title;
  final bool hasDeleteButton;
  @override
  State<StatefulWidget> createState() => _CustomTodoDialogState();
}

class _CustomTodoDialogState extends State<CustomTodoDialog> {
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
    return AlertDialog.adaptive(
      title: Text(widget.title),
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
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (widget.hasDeleteButton) ...[
              _deleteItem(),
              const Expanded(
                  child: Placeholder(
                color: Colors.transparent,
                fallbackHeight: 0,
              )),
            ],
            cancelButton(context), // Pass todo as backup
            okButton(context, todo),
          ],
        )
      ],
    );
  }

  TextButton _deleteItem() => TextButton(
      onPressed: () {
        //Deleted
      },
      child: const Text("Delete"));
}
