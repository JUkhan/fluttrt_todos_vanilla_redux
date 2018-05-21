import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_vanilla_redux/keys.dart';
import 'package:todo_vanilla_redux/localization/localizations.dart';
import 'package:todo_vanilla_redux/vanilla/models.dart';
import 'package:todo_vanilla_redux/vanilla/screens/add_edit_screen.dart';
import 'package:todo_vanilla_redux/vanilla/widgets/typedefs.dart';

class DetailScreen extends StatelessWidget {
  final Todo todo;
  final Function onDelete;
  final TodoAdder addTodo;
  final TodoUpdater updateTodo;

  DetailScreen({
    @required this.todo,
    @required this.addTodo,
    @required this.updateTodo,
    @required this.onDelete,
  }) : super(key: AppKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).todoDetails),
        actions: [
          IconButton(
            key: AppKeys.deleteTodoButton,
            tooltip: AppLocalizations.of(context).deleteTodo,
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.pop(context, todo);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Checkbox(
                    value: todo.complete,
                    key: AppKeys.detailsTodoItemCheckbox,
                    onChanged: (complete) {
                      updateTodo(todo, complete: !todo.complete);
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: 16.0,
                        ),
                        child: Text(
                          todo.task,
                          key: AppKeys.detailsTodoItemTask,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      Text(
                        todo.note,
                        key: AppKeys.detailsTodoItemNote,
                        style: Theme.of(context).textTheme.subhead,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: AppLocalizations.of(context).editTodo,
        child: Icon(Icons.edit),
        key: AppKeys.editTodoFab,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddEditScreen(
                  key: AppKeys.editTodoScreen,
                  updateTodo: updateTodo,
                  addTodo: addTodo,
                  todo: todo,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
