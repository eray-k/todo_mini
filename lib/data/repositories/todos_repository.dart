import 'dart:async';

import '../../core/datastate.dart';
import '../data_sources/todos_service.dart';
import '../models/todo.dart';

typedef TodoPacket = DataState<List<Todo>>;

class TodosRepository {
  final TodosService _todosService;
  TodosRepository(this._todosService);

  Map<int, Todo> todos = const {};

  FutureOr<TodoPacket> getTodos({bool forceRefresh = false}) async {
    if (forceRefresh || todos.isEmpty) {
      final data = await _todosService.readTodos();
      //memoize
      todos = {for (var e in data) e.hashCode: e};
    }
    return DataSuccess(todos.values.toList());
  }

  Future<void> setTodos(List<Todo> target, {bool sync = true}) async {
    todos.addEntries(target.map((e) => MapEntry(e.hashCode, e)));
    if (sync) await this.sync();
  }

  Future<void> removeTodos(List<Todo> target) async {
    for (Todo t in target) {
      todos.remove(t.hashCode);
    }
  }

  Future<void> sync() async {
    await _todosService.writeTodos(todos.values.toList());
  }
}
