import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme_manager.dart';
import 'data/data_sources/todos_service.dart';
import 'data/repositories/todos_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton(await SharedPreferences.getInstance());
  sl.registerSingleton(await ThemeManager(sl()).instance());
  sl.registerSingleton(TodosService(sl()));

  sl.registerSingleton(TodosRepository(sl()));
}
