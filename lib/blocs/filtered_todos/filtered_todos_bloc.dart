import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_state.dart';
import 'package:flutter_challenge_todo_app/models/todo.dart';
import 'package:flutter_challenge_todo_app/models/visibility_filter.dart';

import 'filtered_todos_event.dart';
import 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;

  late StreamSubscription todosSubscrition;
  FilteredTodosBloc({required this.todosBloc})
      : super(
          todosBloc.state is TodosLoadSuccess
              ? FilteredTodosLoaded((todosBloc.state as TodosLoadSuccess).todos,
                  VisibilityFilter.all)
              : FilteredTodosLoading(),
        ) {

    todosSubscrition = todosBloc.stream.listen((state) {
      if (state is TodosLoadSuccess) {
        add(TodosUpdated((todosBloc.state as TodosLoadSuccess).todos));
      }

      on<FilterUpdated>(_onFilterated);
      
      on<TodosUpdated>(_onTodosUpdated);
    
    });
  }

  void _onFilterated(
      FilterUpdated event, Emitter<FilteredTodosState> emit) async {
    if (todosBloc.state is TodosLoadSuccess) {
      emit(FilteredTodosLoaded(
          _todosToFilteredTodos(
            (todosBloc.state as TodosLoadSuccess).todos,
            event.filter,
          ),
          event.filter));
    }
  }

  void _onTodosUpdated(TodosUpdated event, Emitter<FilteredTodosState> emit) {
    final visivilityFilter = state is FilteredTodosLoaded
        ? (state as FilteredTodosLoaded).activeFilter
        : VisibilityFilter.all;

    emit(FilteredTodosLoaded(
        _todosToFilteredTodos(
            (todosBloc.state as TodosLoadSuccess).todos, visivilityFilter),
        visivilityFilter));
  }

  List<Todo> _todosToFilteredTodos(List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    todosSubscrition.cancel();
    return super.close();
  }
}
