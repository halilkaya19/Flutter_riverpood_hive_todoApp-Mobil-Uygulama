import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapphiveriverpoodoneweek/constants/colors_constants.dart';
import 'package:todoapphiveriverpoodoneweek/models/todo_model.dart';
import 'package:todoapphiveriverpoodoneweek/providers/todos_state.dart';
import '../constants/margin_constants.dart';
import '../constants/padding_constant.dart';
import '../constants/text_constant.dart';
import '../constants/textstyle_constants.dart';
import '../providers/all_provider.dart';
import '../widget/appbar_icons.dart';
import '../widget/list_items_widget.dart';


class TodoHomePages extends ConsumerWidget {

  TodoHomePages({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _keyScaffold,
        backgroundColor: AppColors.ScaffoldbackGroundColor,
        appBar: AppBar(
          title: Text(TextApp.appBarText, style: TextStyleApp.appBarTextStyle),
          actions: [
            AppbarIcons(hover: () => _createAddList(context,ref), icons: const Icon(Icons.add)),
          ],
        ),
        body:  _ListViewContent(),
      ),
    );
  }

  void _createAddList(BuildContext context,WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: PaddingApp.addInputPadding,
            child: TextField(
              style: TextStyleApp.inputTextStyle,
              decoration: InputDecoration(
                border:const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: TextApp.inputHintText
              ),
              onSubmitted: (String girilengrv){
                  Navigator.pop(context);
                  DatePicker.showTimePicker(context,showSecondsColumn:false,onConfirm: (time){
                        TodoModel todoModel = TodoModel.created(todoname: girilengrv, times: time);
                        ref.read(stateTodoListManager.notifier).TodoEkle(todoModel);
                  });
              },
            ),
          ),
        );
      },
    );
  }
}

class _ListViewContent extends ConsumerWidget {

  const _ListViewContent({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stateTodoListManager);
    if (state is TodosInitial) {
      return const SizedBox();
    } else if (state is NotesLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is TodosEmpty) {
      return Center(
        child: Text(TextApp.ListContentEmpty),
      );
    } else if (state is TodosLoad){
       EasyLoading.showSuccess("Başarıyla Eklediniz",duration:const Duration(seconds:1));
      return ListViewData(state.todoModel);
    }else {
      return Text(TextApp.ListContentError);
    }
  }
}

class ListViewData extends ConsumerWidget {

  const ListViewData(List<TodoModel>? this.todos, {Key? key,}) : super(key: key);
  final todos;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ListView.builder(itemBuilder: (context, index) {
      return Dismissible(
        key: Key(todos[index].id),
        onDismissed: (_){
            ref.read(stateTodoListManager.notifier).todoDelete(todos[index].id);
        },
        child: Card(
          margin: MarginApp.CardMargin,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                  color: Colors.black38
              )
          ),
          elevation: 2,
          child: ListItemWidget(todomodels:todos[index]),
        ),
      );
    },itemCount:todos.length,);
  }

}
