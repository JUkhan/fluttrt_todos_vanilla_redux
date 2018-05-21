import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_vanilla_redux/keys.dart';
import 'package:todo_vanilla_redux/localization/localizations.dart';
import 'package:todo_vanilla_redux/vanilla/models.dart';
import 'package:todo_vanilla_redux/vanilla/screens/detail_screen.dart';
import 'package:todo_vanilla_redux/vanilla/widgets/todo_item.dart';
import 'package:todo_vanilla_redux/vanilla/widgets/typedefs.dart';

class TodoList extends StatelessWidget {
  final List<Todo> filteredTodos;
  final bool loading;
  final TodoUpdater updateTodo;
  final TodoRemover removeTodo;
  final TodoAdder addTodo;
  TodoList(
      {@required this.filteredTodos,
      @required this.loading,
      @required this.updateTodo,
      @required this.addTodo,
      @required this.removeTodo})
      : super(key: AppKeys.todoList);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: loading
            ? CircularProgressIndicator(
                key: AppKeys.todosLoading,
              )
            : ListView.builder(
                key: AppKeys.todoList,
                itemCount: filteredTodos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = filteredTodos[index];
                  return TodoItem(
                      todo: todo,
                      onCheckboxChanged: (complete) {
                        updateTodo(todo, complete: complete);
                      },
                      onDismissed: (direction) {
                        _removeTodo(context, todo);
                      },
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return DetailScreen(
                                todo: todo,
                                onDelete: () => _removeTodo(context, todo),
                                addTodo: addTodo,
                                updateTodo: updateTodo,
                              );
                            },
                          ),
                        );
                      });
                },
              ));
  }

  void _removeTodo(BuildContext context, Todo todo) {
    removeTodo(todo);

    Scaffold.of(context).showSnackBar(
          SnackBar(
            key: AppKeys.snackbar,
            duration: Duration(seconds: 2),
            backgroundColor: Theme.of(context).backgroundColor,
            content: Text(
              AppLocalizations.of(context).todoDeleted(todo.task),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            action: SnackBarAction(
              label: AppLocalizations.of(context).undo,
              onPressed: () {
                addTodo(todo);
              },
            ),
          ),
        );
  }
}
