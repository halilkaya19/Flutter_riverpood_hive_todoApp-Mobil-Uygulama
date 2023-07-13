import 'package:todoapphiveriverpoodoneweek/models/todo_model.dart';

abstract class TodoState {
  TodoState();
}
class TodosInitial extends TodoState {
  TodosInitial();
}

class NotesLoading extends TodoState {
  NotesLoading();
}

class TodosLoad extends TodoState {
  TodosLoad({
    this.todoModel,
  });
  final List<TodoModel>? todoModel;
}

class TodosEmpty extends TodoState {
  TodosEmpty();
}

class TodosErro extends TodoState {
  TodosErro();
}

class NotesSuccess extends TodoState {
  NotesSuccess();
}
