import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final bool complete;
  final String? id;
  final String note;
  final String task;

  const Todo(
    this.task, {
    this.complete = false,
    String note = '',
    String? id,
  })  : note = note,
        id = '';

  Todo copyWith({bool? complete, String? id, String? note, String? task}) {
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  @override
  List<Object> get props => [complete, id!, note, task];

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $note, id: $id }';
  }
}
//Demo Todos
List<Todo> todosDemo = const [
  Todo("task", note: 'note'),
  Todo('task1', note: 'note1'),
  Todo('task2', note: 'note2')
];
