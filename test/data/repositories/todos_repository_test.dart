import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_mini/data/data_sources/todos_service.dart';
import 'package:todo_mini/data/repositories/todos_repository.dart';

@GenerateNiceMocks([MockSpec<TodosService>()])
@GenerateNiceMocks([MockSpec<TodosRepository>()])
import 'todos_repository_test.mocks.dart';

void main() {
  late final MockTodosService mockService;
  late final TodosRepository todosRepository;
  setUp(() {
    mockService = MockTodosService();
    todosRepository = TodosRepository(mockService);
  });

  group('read data from service and store it', () {
    when(mockService.readTodos()).thenAnswer((realInvocation) => Future.value(List.empty()));
  });
}
