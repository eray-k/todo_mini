import '../../data/models/todo.dart';

import '../../data/repositories/todos_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../injector.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoNotifier extends _$TodoNotifier {
  @override
  FutureOr<TodoPacket> build() async {
    return await sl<TodosRepository>().getTodos();
  }

  Future<void> updateTodo(Todo oldTodo, Todo newTodo) async {
    await Future.wait([
      sl<TodosRepository>().removeTodos([oldTodo]),
      sl<TodosRepository>().setTodos([newTodo])
    ]);
    ref.invalidate(todoNotifierProvider);
  }

  Future<void> addTodo(Todo newTodo) async {
    await sl<TodosRepository>().setTodos([newTodo]);
    ref.invalidate(todoNotifierProvider);
  }
}
