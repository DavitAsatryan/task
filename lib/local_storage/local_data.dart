import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const saveTodos = 'save_todos';
}

class LocalService {
  final _storage = const FlutterSecureStorage();
  Future<void> setTodos(List<String> value) async {
    final storage = _storage;
    storage.write(key: _Keys.saveTodos, value: jsonEncode(value));
  }

  Future<List> readTodos() async {
    final storage = _storage;
    String? todos = await storage.read(key: _Keys.saveTodos);
    List<dynamic> listTosos = jsonDecode(todos!);
    return listTosos;
  }

  delete() async {
    final storage = _storage;
    storage.deleteAll();
  }
}
