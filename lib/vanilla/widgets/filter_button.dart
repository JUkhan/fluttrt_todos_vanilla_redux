import 'package:flutter/material.dart';
import 'package:todo_vanilla_redux/keys.dart';
import 'package:todo_vanilla_redux/localization/localizations.dart';
import 'package:todo_vanilla_redux/vanilla/models.dart';

class FilterButton extends StatelessWidget {
  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final bool isActive;

  FilterButton({this.onSelected, this.activeFilter, this.isActive, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.body1;
    final activeStyle = Theme
        .of(context)
        .textTheme
        .body1
        .copyWith(color: Theme.of(context).accentColor);
    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.0,
      duration: Duration(microseconds: 150),
      child: PopupMenuButton<VisibilityFilter>(
        key: AppKeys.filterButton,
        icon: Icon(Icons.filter_list),
        tooltip: AppLocalizations.of(context).filterTodos,
        onSelected: onSelected,
        itemBuilder: (BuildContext context) =>
            <PopupMenuItem<VisibilityFilter>>[
              PopupMenuItem<VisibilityFilter>(
                key: AppKeys.allFilter,
                value: VisibilityFilter.all,
                child: Text(
                  AppLocalizations.of(context).showAll,
                  style: activeFilter == VisibilityFilter.all
                      ? activeStyle
                      : defaultStyle,
                ),
              ),
              PopupMenuItem<VisibilityFilter>(
                  key: AppKeys.activeFilter,
                  value: VisibilityFilter.active,
                  child: Text(
                    AppLocalizations.of(context).showActive,
                    style: activeFilter == VisibilityFilter.active
                        ? activeStyle
                        : defaultStyle,
                  )),
              PopupMenuItem<VisibilityFilter>(
                key: AppKeys.completedFilter,
                value: VisibilityFilter.completed,
                child: Text(
                  AppLocalizations.of(context).showCompleted,
                  style: activeFilter == VisibilityFilter.completed
                      ? activeStyle
                      : defaultStyle,
                ),
              )
            ],
      ),
    );
  }
}
