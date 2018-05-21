import 'dart:async';

import 'package:todo_vanilla_redux/todos_repository/todo_entity.dart';


class WebClient{
  final Duration delay;

  const WebClient([this.delay=const Duration(microseconds:3000)]);

  Future<List<TodoEntity>> fetchTodos() async{
   
    return Future.delayed(
        delay,
        () => [
              TodoEntity(
                'Buy food for da kitty',
                '1',
                'With the chickeny bits!',
                false,
              ),
              TodoEntity(
                'Find a Red Sea dive trip',
                '2',
                'Echo vs MY Dream',
                false,
              ),
              TodoEntity(
                'Book flights to Egypt',
                '3',
                '',
                true,
              ),
              TodoEntity(
                'Decide on accommodation',
                '4',
                '',
                false,
              ),
              TodoEntity(
                'Sip Margaritas',
                '5',
                'on the beach',
                true,
              ),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postTodos(List<TodoEntity> todos) async {
    return Future.value(true);
  }

}