import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_mini/core/constants.dart';
import 'package:todo_mini/data/data_sources/todos_service.dart';
import 'package:todo_mini/data/models/todo.dart';

Future<TodosService> initSharedPreferences(Map<String, Object> data) async {
  SharedPreferences.setMockInitialValues(data);
  final prefs = await SharedPreferences.getInstance();
  final TodosService service = TodosService(prefs);
  return service;
}

void main() {
  setUp(() => {});
  group('write/read todos', () {
    final List<Todo> tTodoListDecoded = [
      Todo(content: 'Test1', dueDate: DateTime(2023, 1, 1)),
      Todo(content: 'Test2', dueDate: DateTime(2023, 1, 1))
    ].toList();

    const String tTodoListEncoded =
        '[{"content":"Test1","dueDate":"2023-01-01T00:00:00.000"},{"content":"Test2","dueDate":"2023-01-01T00:00:00.000"}]';

    group('read', () {
      test('should read todos when prefs are empty', () async {
        final service = await initSharedPreferences({});
        final result = await service.readTodos();
        expect(result, List.empty());
      });
      test('should read todos when prefs are valid', () async {
        final service =
            await initSharedPreferences({TODOS_LOCAL_KEY: tTodoListEncoded});
        final result = await service.readTodos();
        expect(result, tTodoListDecoded);
      });
      test('should refresh todos when prefs data is invalid', () async {
        final service =
            await initSharedPreferences({TODOS_LOCAL_KEY: "Invalid Json!!!"});
        final result = await service.readTodos();
        expect(result, firstTodos);
        //
        final service2 =
            await initSharedPreferences({TODOS_LOCAL_KEY: '["a":0]'});
        final result2 = await service2.readTodos();
        expect(result2, firstTodos);
      });
    });
    test('should write todos and read them', () async {
      final service = await initSharedPreferences({});
      await service.writeTodos(tTodoListDecoded);
      final result = await service.readTodos();
      expect(result, tTodoListDecoded);
    });
  });
}
