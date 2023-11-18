import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_mini/core/util/date_converter.dart';
import 'package:todo_mini/presentation/widgets/add_todo_dialog.dart';

import '../../core/datastate.dart';
import '../../data/models/todo.dart';
import '../controllers/todo_provider.dart';
import '../widgets/edit_todo_dialog.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 72.0),
        child: _buildBody(context, ref),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(ref.read(todoNotifierProvider).asData?.value.data);
        },
        child: const Icon(Icons.bug_report),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    return ref.watch(todoNotifierProvider).when(
          data: (data) {
            if (data is DataFailed) {
              return Text('Error occured : ${data.exception}');
            }
            final todoList = data.data!;
            print(todoList);
            return Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    color: Theme.of(context).colorScheme.secondaryContainer),
                child: ListView.builder(
                    itemCount: todoList.length + 1, // One for add task button
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                //TODO: Add Task Window
                                print("Add New Task");
                                _showDialog(context, ref,
                                    (context) => const AddTodoDialog(),
                                    (resultTodo) {
                                  ref
                                      .read(todoNotifierProvider.notifier)
                                      .addTodo(resultTodo);
                                });
                              },
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 8.0),
                                  child: Text(
                                    "Add Task",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ))),
                        );
                      }
                      final item = todoList[index - 1];
                      final daysLeft =
                          item.dueDate.difference(DateTime.now()).inDays;
                      final daysLeftStr =
                          DateConverter.convert(daysLeft, false);
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              print("Edit Task"); //Edit Task Window
                              _showDialog(
                                  context,
                                  ref,
                                  (context) =>
                                      EditTodoDialog(initialTodo: item),
                                  (resultTodo) {
                                ref
                                    .read(todoNotifierProvider.notifier)
                                    .updateTodo(item, resultTodo);
                              });
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 8.0),
                                child: Text(
                                  "${item.content} /// $daysLeftStr",
                                  style: item.isCompleted
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough)
                                      : null,
                                ))),
                      );
                    }));
          },
          error: (error, stackTrace) => Text('Error occured : $error'),
          loading: () => const CircularProgressIndicator(),
        );
  }

  Future<void> _showDialog(
      BuildContext context,
      WidgetRef ref,
      Widget Function(BuildContext context) build,
      void Function(Todo todo) callback) async {
    Todo? resultTodo = await showDialog(
      context: context,
      builder: build,
    );
    if (resultTodo == null) return;
    callback(resultTodo);
  }
}
