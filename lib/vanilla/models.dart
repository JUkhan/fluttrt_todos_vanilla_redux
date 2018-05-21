import 'package:todo_vanilla_redux/todos_repository/todo_entity.dart';
import 'package:todo_vanilla_redux/uuid.dart';

class AppState {
  bool isLoading;
  List<Todo> todos;

  AppState({
    this.isLoading = false,
    this.todos = const [],
  });
  factory AppState.loading() => AppState(isLoading: true);

  List<Todo> filteredTodos(VisibilityFilter activeFilter) {
    return todos.where((todo) {
      switch (activeFilter) {
        case VisibilityFilter.all:
          return true;
        case VisibilityFilter.completed:
          return todo.complete;
        case VisibilityFilter.active:
          return !todo.complete;
      }
    }).toList();
  }
  bool get allComplete => todos.every((todo) => todo.complete);
  bool get hasCompletedTodos => todos.any((todo) => todo.complete);
  int get numActive =>
      todos.fold(0, (sum, todo) => !todo.complete ? ++sum : sum);

  int get numCompleted =>
      todos.fold(0, (sum, todo) => todo.complete ? ++sum : sum);

  void clearCompleted() {
    todos.removeWhere((todo) => todo.complete);
  }

  void toggleAll() {
    final allCompleted = this.allComplete;

    todos.forEach((todo) => todo.complete = !allCompleted);
  }
  @override
  int get hashCode => isLoading.hashCode ^ todos.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          todos == other.todos;

  @override
  String toString() {
    // TODO: implement toString
    return 'Todo{ todos: $todos, isLoading: $isLoading}';
  }
}

enum AppTab { todos, stats }

enum ExtraAction { toggleAllComplete, clearCompleted }

class Todo {
  bool complete;
  String id;
  String note;
  String task;

  Todo(this.task, {this.complete = false, this.note = '', String id})
      : this.id = id ?? Uuid().generateV4();

  @override
  int get hashCode =>
      complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id;

  @override
  String toString() {
    return 'Todo{complete: $complete, task: $task, note: $note, id: $id}';
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      complete: entity.complete ?? false,
      note: entity.note,
      id: entity.id ?? Uuid().generateV4(),
    );
  }
}

enum VisibilityFilter { all, active, completed }
