import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_vanilla_redux/keys.dart';
import 'package:todo_vanilla_redux/localization/localizations.dart';
import 'package:todo_vanilla_redux/vanilla/models.dart';
import 'package:todo_vanilla_redux/vanilla/widgets/typedefs.dart';

class AddEditScreen extends StatelessWidget {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> taskKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> noteKey =
      GlobalKey<FormFieldState<String>>();

  final Todo todo;
  final TodoAdder addTodo;
  final TodoUpdater updateTodo;

  AddEditScreen({
    Key key,
    @required this.addTodo,
    @required this.updateTodo,
    this.todo,
  }) : super(key: key ??  AppKeys.addTodoScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing
            ? AppLocalizations.of(context).editTodo
            : AppLocalizations.of(context).addTodo),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidate: false,
          onWillPop: () {
            return  Future(() => true);
          },
          child: ListView(
            children: [
              TextFormField(
                initialValue: todo != null ? todo.task : '',
                key: taskKey,
                autofocus: isEditing ? false : true,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).newTodoHint),
                validator: (val) => val.trim().isEmpty
                    ? AppLocalizations.of(context).emptyTodoError
                    : null,
              ),
              TextFormField(
                initialValue: todo != null ? todo.note : '',
                key: noteKey,
                maxLines: 10,
                style: Theme.of(context).textTheme.subhead,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).notesHint,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: isEditing
              ? AppLocalizations.of(context).saveChanges
              : AppLocalizations.of(context).addTodo,
          child: Icon(isEditing ? Icons.check : Icons.add),
          onPressed: () {
            final form = formKey.currentState;
            if (form.validate()) {
              final task = taskKey.currentState.value;
              final note = noteKey.currentState.value;

              if (isEditing) {
                updateTodo(todo, task: task, note: note);
              } else {
                addTodo(Todo(
                  task,
                  note: note,
                ));
              }

              Navigator.pop(context);
            }
          }),
    );
  }

  bool get isEditing => todo != null;
}
