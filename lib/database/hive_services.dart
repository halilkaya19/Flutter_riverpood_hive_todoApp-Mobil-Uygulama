import 'package:hive/hive.dart';
import 'package:todoapphiveriverpoodoneweek/models/todo_model.dart';

import 'Database_services.dart';

class HiveLocalServices implements DatabaseLocalServices{

  late Box<TodoModel> box;

  HiveLocalServices(){
    box = Hive.box<TodoModel>('todoModels');
  }

  @override
  Future<List<TodoModel>> getAllTask() async{
    List<TodoModel> _alltask = [];
    _alltask = box.values.toList();
    return _alltask;
  }

  @override
  Future<bool> removeTodo({required String id}) async{
      await box.delete(id);
      return Future.value(true);
  }

  @override
  Future<bool> updateTodo({required TodoModel todos}) async{
    await box.put(todos.id, todos);
    return Future.value(true);
  }

  @override
  Future<bool> addTodo({required TodoModel todos}) async{
    await box.put(todos.id, todos);
    return Future.value(true);
  }


}