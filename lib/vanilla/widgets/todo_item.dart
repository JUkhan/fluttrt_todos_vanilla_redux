import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_vanilla_redux/keys.dart';
import 'package:todo_vanilla_redux/vanilla/models.dart';
import 'package:todo_vanilla_redux/vanilla/widgets/typedefs.dart';


class TodoItem extends StatelessWidget {
  final Todo todo;
  final ValueChanged<bool> onCheckboxChanged;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  TodoItem({ 
    Key key,    
    @required this.todo, 
    @required this.onCheckboxChanged,
    @required this.onDismissed,
    @required this.onTap
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key:AppKeys.todoItem(todo.id) ,
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          key: AppKeys.todoItemCheckbox(todo.id),
          value: todo.complete,
          onChanged:onCheckboxChanged,
        ),
        title: Text(
          todo.task,
          key: AppKeys.todoItemTask(todo.id),
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          todo.note,
          key: AppKeys.todoItemNote(todo.id),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
      );
  }
}