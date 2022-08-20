import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_event.dart';
import 'package:flutter_challenge_todo_app/models/todo.dart';
import 'package:flutter_challenge_todo_app/screens/details_screen.dart';

import '../blocs/filtered_todos/filtered_todos_bloc.dart';
import '../blocs/filtered_todos/filtered_todos_state.dart';
import 'delete_todo_snack_bar.dart';
import 'todo_item.dart';

class FilteredTodos extends StatelessWidget {
  const FilteredTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (
        BuildContext context,
        FilteredTodosState state,
      ) {
        if (state is FilteredTodosLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FilteredTodosLoaded) {
          final todos = state.filteredTodos;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];
              return TodoItem(
                todo: todo,
                onDismissed: (_) {
                  BlocProvider.of<TodosBloc>(context).add(TodoDeleted(todo));
                  Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                    todo: todo,
                    onUndo: () => BlocProvider.of<TodosBloc>(context)
                        .add(TodoAdded(todo)),
                  ));
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push<Todo>(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: todo.id);
                    }),
                  );
                  if (removedTodo != null) {
                    Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                      todo: todo,
                      onUndo: () => BlocProvider.of<TodosBloc>(context)
                          .add(TodoAdded(todo)),
                    ));
                  }
                },
                onCheckboxChanged: (_) {
                  BlocProvider.of<TodosBloc>(context).add(
                      TodoUpdated(todo.copyWith(complete: !todo.complete)));
                },
              );
            },
          );
        } else {
          return Container(child: const Text("Empty"));
        }
      },
    );
  }
}
