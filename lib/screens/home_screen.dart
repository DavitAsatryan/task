import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_todo_app/screens/add_edit_screen.dart';
import 'package:flutter_challenge_todo_app/widgets/extra_actions.dart';
import 'package:flutter_challenge_todo_app/widgets/filter_button.dart';
import 'package:flutter_challenge_todo_app/widgets/filtered_todos.dart';
import 'package:flutter_challenge_todo_app/widgets/stats.dart';

import '../blocs/tab/tab_bloc.dart';
import '../blocs/tab/tab_event.dart';
import '../models/app_tab.dart';
import '../widgets/tab_selector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo'),
            actions: [
              FilterButton(visible: activeTab == AppTab.todos),
              const ExtraActions(),
            ],
          ),
          body:
              activeTab == AppTab.todos ? const FilteredTodos() : const Stats(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AddEditScreen(
                          isEditing: false, onSave: ((task, note) => task))));
            },
            tooltip: "Add Todo",
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );
  }
}
