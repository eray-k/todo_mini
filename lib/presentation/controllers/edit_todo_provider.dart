import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/todo.dart';

part 'edit_todo_provider.g.dart';

@riverpod
class EditedTodoNotifier extends _$EditedTodoNotifier {
  @override
  Todo build() {
    //FIXME: ADD PLACEHOLDER TODO
    return Todo(content: "", dueDate: DateTime(2000, 1, 1));
  }
}
