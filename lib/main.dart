import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/filtered_todos/filtered_todos_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/stats/stats_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/tab/tab_bloc.dart';
import 'package:flutter_challenge_todo_app/blocs/todos/todos_bloc.dart';
import 'package:flutter_challenge_todo_app/screens/home_screen.dart';

import 'blocs/my_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider<TodosBloc>(
    create: (context) {
      return TodosBloc();
    },
    child: const TodosApp(),
  ));

  Bloc.observer = MyBlocObserver();
}

class TodosApp extends StatelessWidget {
  const TodosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);

    return MaterialApp(
        home: MultiBlocProvider(
      providers: [
        BlocProvider<TabBloc>(
          create: (context) => TabBloc(),
        ),
        BlocProvider<FilteredTodosBloc>(
          create: (context) => FilteredTodosBloc(todosBloc: todosBloc),
        ),
        BlocProvider<StatsBloc>(
          create: (context) => StatsBloc(todosBloc: todosBloc),
        ),
      ],
      child: const HomeScreen(),
    ));
  }
}
