import 'dart:core';

import 'package:flutter_challenge_todo_app/local_storage/local_data.dart';
import 'package:flutter_challenge_todo_app/models/todo.dart';

class TodoReposiotry {
  final _localService = LocalService();

  
  Future<List> fetchTodos() async {
    return Future.delayed(
        const Duration(microseconds: 1500), () => [todosDemo]);
  }

  Future<Future<List>> saveTodos(todos) async {
    return Future.wait<dynamic>([_localService.setTodos(todos)]);
  }
}
