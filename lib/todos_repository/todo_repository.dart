import 'dart:async';
import './todo_entity.dart';

abstract class TodoRepository{
  Future<List<TodoEntity>> loadTodos();
  Future saveTodos(List<TodoEntity> todos);
} 