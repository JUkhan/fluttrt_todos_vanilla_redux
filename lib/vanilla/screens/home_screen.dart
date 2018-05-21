import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_vanilla_redux/keys.dart';
import 'package:todo_vanilla_redux/localization/localizations.dart';
import 'package:todo_vanilla_redux/routes.dart';
import 'package:todo_vanilla_redux/vanilla/models.dart';
import 'package:todo_vanilla_redux/vanilla/widgets/extra_actions_button.dart';
import 'package:todo_vanilla_redux/vanilla/widgets/filter_button.dart';
import 'package:todo_vanilla_redux/vanilla/widgets/stats_counter.dart';
import 'package:todo_vanilla_redux/vanilla/widgets/todo_list.dart';
import 'package:todo_vanilla_redux/vanilla/widgets/typedefs.dart';

class HomeScreen extends StatefulWidget {
  final AppState appState;
  final TodoUpdater updateTodo;
  final Function toggleAll;
  final Function clearCompleted;
  final TodoRemover removeTodo;
  final TodoAdder addTodo;
  HomeScreen({
    @required this.appState,
    @required this.updateTodo,
    @required this.toggleAll,
    @required this.clearCompleted,
    @required this.addTodo,
    @required this.removeTodo,
  });

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VisibilityFilter activeFilter = VisibilityFilter.all;
  AppTab activeTab = AppTab.todos;
  _updateVisibility(VisibilityFilter filter) {
    setState(() {
      activeFilter = filter;
    });
  }

  _updateTab(AppTab tab) {
    setState(() {
      activeTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle('Vanilla')),
        actions: <Widget>[
          FilterButton(
            activeFilter: activeFilter,
            isActive: AppTab.todos == activeTab,
            onSelected: _updateVisibility,
          ),
          new ExtraActionsButton(
            allComplete: widget.appState.allComplete,
            hasCompletedTodos: widget.appState.hasCompletedTodos,
            onSelected: (action) {
              if (action == ExtraAction.toggleAllComplete) {
                widget.toggleAll();
              } else if (action == ExtraAction.clearCompleted) {
                widget.clearCompleted();
              }
            },
          )
        ],
      ),
      body: activeTab == AppTab.todos
          ? TodoList(
              filteredTodos: widget.appState.filteredTodos(activeFilter),
              loading: widget.appState.isLoading,
              updateTodo: widget.updateTodo,
              removeTodo: widget.removeTodo,
              addTodo: widget.addTodo,
            )
          : StatsCounter(
              numActive: widget.appState.numActive,
              numCompleted: widget.appState.numCompleted,
            ),
      floatingActionButton: FloatingActionButton(
        key: AppKeys.addTodoFab,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addTodo);
        },
        child: Icon(Icons.add),
        tooltip: AppLocalizations.of(context).addTodo,
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: AppKeys.tabs,
        currentIndex: AppTab.values.indexOf(activeTab),
        onTap: (index) {
          _updateTab(AppTab.values[index]);
        },
        items: AppTab.values.map((tab) {
          return BottomNavigationBarItem(
            icon: Icon(
              tab == AppTab.todos ? Icons.list : Icons.show_chart,
              key: tab == AppTab.stats ? AppKeys.statsTab : AppKeys.todoTab,
            ),
            title: Text(
              tab == AppTab.stats
                  ? AppLocalizations.of(context).stats
                  : AppLocalizations.of(context).todos,
            ),
          );
        }).toList(),
      ),
    );
  }
}
