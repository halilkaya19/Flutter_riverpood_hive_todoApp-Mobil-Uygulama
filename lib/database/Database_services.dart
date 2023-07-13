import 'package:todoapphiveriverpoodoneweek/models/todo_model.dart';

abstract class DatabaseLocalServices{
    Future<List<TodoModel>> getAllTask();
    Future<bool> addTodo({required TodoModel todos});
    Future<bool> removeTodo({required String id});
    Future<bool> updateTodo({required TodoModel todos});
}