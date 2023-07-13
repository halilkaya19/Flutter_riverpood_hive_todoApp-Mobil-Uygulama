import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapphiveriverpoodoneweek/models/todo_model.dart';
import 'package:intl/intl.dart';

import '../providers/all_provider.dart';

class ListItemWidget extends ConsumerStatefulWidget {
  ListItemWidget({required this.todomodels, Key? key}) : super(key: key);

  final TodoModel todomodels;

  @override
  ConsumerState<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends ConsumerState<ListItemWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  late FocusNode _textFocusNode;
  late TextEditingController _textController;
  bool _hasFocus = false;
  bool isActives = false;

  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    _textController = TextEditingController();
  }

  void dispose() {
    super.dispose();
    _textFocusNode.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dateString = DateFormat().format(widget.todomodels.times);
    return Focus(
      onFocusChange: (isFocuesed) {
        if (!isFocuesed) {
          setState(() {
            _hasFocus = false;
          });
          TodoModel td = TodoModel(
              id: widget.todomodels.id,
              todoname: _textController.text,
              isActives: widget.todomodels.isActives,
              times: widget.todomodels.times);
          ref.read(stateTodoListManager.notifier).editAdd(td);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
          });
          _textFocusNode.requestFocus();
          _textController.text = widget.todomodels.todoname;
        },
        leading: Checkbox(
          value: widget.todomodels.isActives,
          onChanged: (value) {
            debugPrint("tes $value");
            setState(() {
              isActives = value!;
            });
            TodoModel td = TodoModel(
                id: widget.todomodels.id,
                todoname: widget.todomodels.todoname,
                isActives: isActives,
                times: widget.todomodels.times);
                debugPrint(td.toString());
              ref.read(stateTodoListManager.notifier).editAdd(td);
          },
        ),
        subtitle: GestureDetector(
          onTap: () {
            _textEditingController.text = widget.todomodels.todoname;
          },
          child: Text(dateString),
        ),
        title: _hasFocus
            ? TextField(
                controller: _textController,
                focusNode: _textFocusNode,
              )
            : Text(widget.todomodels.todoname),
      ),
    );
  }
}
