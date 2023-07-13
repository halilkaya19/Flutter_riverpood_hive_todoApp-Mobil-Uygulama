import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapphiveriverpoodoneweek/providers/todos_manager.dart';
import 'package:todoapphiveriverpoodoneweek/providers/todos_state.dart';
import '../database/Database_services.dart';
import '../database/hive_services.dart';


final stateTodoListManager = StateNotifierProvider<TodoStateManager,TodoState>((ref) {
    return TodoStateManager(ref: ref);
});

