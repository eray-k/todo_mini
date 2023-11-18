import 'package:flutter/material.dart';
import 'package:todo_mini/presentation/widgets/custom_todo_dialog.dart';
import '../../data/models/todo.dart';

class AddTodoDialog extends StatelessWidget {
  const AddTodoDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomTodoDialog(
      initialTodo: Todo(
          content: "", dueDate: DateTime.now().add(const Duration(days: 3))),
      title: "Add Task",
      hasDeleteButton: false,
    );
  }
}
