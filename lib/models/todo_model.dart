import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel extends HiveObject{
  @HiveField(0)
  final String id;
  @HiveField(1)
  String todoname;
  @HiveField(2)
  bool isActives;
  @HiveField(3)
  final DateTime times;

  TodoModel({required this.id,required this.todoname,required this.isActives,required this.times});

  factory TodoModel.created({required String todoname,required DateTime times}){
    return TodoModel(id: Uuid().v4(), todoname: todoname, isActives: false, times: times);
  }
}