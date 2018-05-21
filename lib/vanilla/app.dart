import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meta/meta.dart';
import 'package:todo_vanilla_redux/keys.dart';
import 'package:todo_vanilla_redux/localization/localizations.dart';
import 'package:todo_vanilla_redux/routes.dart';
import 'package:todo_vanilla_redux/theme.dart';
import 'package:todo_vanilla_redux/todos_repository/todo_repository.dart';
import 'package:todo_vanilla_redux/vanilla/models.dart';
import 'package:todo_vanilla_redux/vanilla/screens/add_edit_screen.dart';
import 'package:todo_vanilla_redux/vanilla/screens/home_screen.dart';

class VanillaApp extends StatefulWidget {
  final TodoRepository repository;
  VanillaApp({@required this.repository});
  @override
  _VanillaAppState createState() => new _VanillaAppState();
}

class _VanillaAppState extends State<VanillaApp> {
  AppState appState = AppState.loading();
  @override
  void initState() {
    super.initState();
    widget.repository.loadTodos().then((todos) {
      setState(() {
        appState = AppState(
            todos: todos.map((entity) => Todo.fromEntity(entity)).toList());
      });
    }).catchError(() {
      setState(() {
        appState.isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Vanilla',
      theme: AppTheme.theme,
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routes: {
        AppRoutes.home: (context) => HomeScreen(
              appState: appState,
              updateTodo: updateTodo,
              addTodo: addTodo,
              removeTodo: removeTodo,
              toggleAll: toggleAll,
              clearCompleted: clearCompleted,
            ),
        AppRoutes.addTodo: (context) {
          return AddEditScreen(
            key: AppKeys.addTodoScreen,
            addTodo: addTodo,
            updateTodo: updateTodo,
          );
        },
      },
      debugShowCheckedModeBanner: false,
    );
  }

  void toggleAll() {
    setState(() {
      appState.toggleAll();
    });
  }

  void clearCompleted() {
    setState(() {
      appState.clearCompleted();
    });
  }

  void addTodo(Todo todo) {
    setState(() {
      appState.todos.add(todo);
    });
  }

  void removeTodo(Todo todo) {
    setState(() {
      appState.todos.remove(todo);
    });
  }

  void updateTodo(
    Todo todo, {
    bool complete,
    String id,
    String note,
    String task,
  }) {
    setState(() {
      todo.complete = complete ?? todo.complete;
      todo.id = id ?? todo.id;
      todo.note = note ?? todo.note;
      todo.task = task ?? todo.task;
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    widget.repository.saveTodos(
      appState.todos.map((todo) => todo.toEntity()).toList(),
    );
  }
}
