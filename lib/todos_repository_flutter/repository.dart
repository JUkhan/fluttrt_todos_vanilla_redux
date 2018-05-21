import 'dart:async';
import 'package:meta/meta.dart';
import 'package:todo_vanilla_redux/todos_repository/todo_entity.dart';
import 'package:todo_vanilla_redux/todos_repository/todo_repository.dart';
import 'package:todo_vanilla_redux/todos_repository_flutter/file_storege.dart';
import 'package:todo_vanilla_redux/todos_repository_flutter/web_client.dart';



/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class TodosRepositoryFlutter implements TodoRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const TodosRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<TodoEntity>> loadTodos() async {
    try {
      return await fileStorage.loadTodos();
    } catch (e) {
      final todos = await webClient.fetchTodos();

      fileStorage.saveTodos(todos);

      return todos;
    }
  }

  // Persists todos to local disk and the web
  @override
  Future saveTodos(List<TodoEntity> todos) {
    return Future.wait<dynamic>([
      fileStorage.saveTodos(todos),
      webClient.postTodos(todos),
    ]);
  }
}