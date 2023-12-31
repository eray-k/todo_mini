import 'package:flutter/material.dart';
import 'package:todo_mini/presentation/widgets/custom_todo_dialog.dart';
import '../../data/models/todo.dart';

class EditTodoDialog extends StatelessWidget {
  const EditTodoDialog({super.key, required this.initialTodo});
  final Todo initialTodo;
  @override
  Widget build(BuildContext context) {
    return CustomTodoDialog(
      initialTodo: initialTodo,
      title: "Edit Task",
      hasDeleteButton: true,
    );
  }
}
