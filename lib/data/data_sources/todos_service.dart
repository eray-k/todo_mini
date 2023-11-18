import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';
import '../models/todo.dart';

class TodosService {
  final SharedPreferences prefs;

  TodosService(this.prefs);

  Future<List<Todo>> readTodos() async {
    final encodedTodoList = prefs.getString(TODOS_LOCAL_KEY);
    if (encodedTodoList == null) {
      //First initialization
      await writeTodos(firstTodos);
      return firstTodos;
    }
    try {
      final decodedTodoList = jsonDecode(encodedTodoList) as List;
      final resultList = decodedTodoList.map((e) => Todo.fromJson(e)).toList();
      return Future.value(resultList);
    } on FormatException {
      prefs.remove(TODOS_LOCAL_KEY);
      //Invalid Json, refresh pref slot
      await writeTodos(firstTodos);
      return firstTodos;
    }
  }

  Future<void> writeTodos(List<Todo> value) async {
    final encodedTodoList = jsonEncode(value.map((e) => e.toJson()).toList());
    await prefs.setString(TODOS_LOCAL_KEY, encodedTodoList);
  }
}
