import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapphiveriverpoodoneweek/models/todo_model.dart';
import 'package:todoapphiveriverpoodoneweek/providers/todos_state.dart';
import '../database/hive_services.dart';


final hivelocalStorage = Provider<HiveLocalServices>((ref){
    return HiveLocalServices();
});


class TodoStateManager extends StateNotifier<TodoState>{


    TodoStateManager({required this.ref}) : dbservices = ref.watch(hivelocalStorage), super(TodosInitial()){
        allNot();
    }
    final Ref ref;
    final HiveLocalServices dbservices;

    Future<void> allNot() async {
        state = NotesLoading();
        try {
            await Future.delayed(const Duration(milliseconds:50));
            final todos = await dbservices.getAllTask();
            if (todos.isEmpty) {
                state = TodosEmpty();
            } else {
                state = TodosLoad(
                    todoModel: todos,
                );
            }
        } catch (e) {
            state = TodosErro();
            throw Exception();
        }
    }

    Future<void> TodoEkle(TodoModel todoModel) async {
        state = NotesLoading();
        try {
            await dbservices.addTodo(todos: todoModel);
            await Future.delayed(const Duration(seconds:1));
            final tb = await dbservices.getAllTask();
            if (tb.isEmpty) {
                state = TodosEmpty();
            } else {
                state = TodosLoad(
                    todoModel:tb,
                );
            }
        } on Exception {
            state = TodosErro();
        }
    }

    Future<void> todoDelete(id) async {
        state = NotesLoading();
        await Future.delayed(const Duration(milliseconds:35));
        try {
            await dbservices.removeTodo(id: id);
            allNot();
        } on Exception {
            state = TodosErro();
        }
    }


    Future<void> editAdd(TodoModel todos) async {
        state = NotesLoading();
        try {
            await dbservices.updateTodo(todos: todos);
            final tb = await dbservices.getAllTask();
            if (tb.isEmpty) {
                state = TodosEmpty();
            } else {
                state = TodosLoad(
                    todoModel:tb,
                );
            }
        } on Exception {
            state = TodosErro();
        }
    }

}