import 'package:flutter/material.dart';
import 'package:todo_vanilla_redux/keys.dart';
import 'package:todo_vanilla_redux/localization/localizations.dart';
import 'package:todo_vanilla_redux/vanilla/models.dart';

class ExtraActionsButton extends StatelessWidget {
  final PopupMenuItemSelected<ExtraAction> onSelected;
  final bool allComplete;
  final bool hasCompletedTodos;

  ExtraActionsButton({
    this.onSelected,
    this.allComplete = false,
    this.hasCompletedTodos = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraAction>(
      key: AppKeys.extraActionsButton,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
            PopupMenuItem<ExtraAction>(
              key: AppKeys.toggleAll,
              value: ExtraAction.toggleAllComplete,
              child: Text(allComplete
                  ? AppLocalizations.of(context).markAllIncomplete
                  : AppLocalizations.of(context).markAllComplete),
            ),
            PopupMenuItem<ExtraAction>(
              key: AppKeys.clearCompleted,
              value: ExtraAction.clearCompleted,
              child: Text(AppLocalizations.of(context).clearCompleted),
            ),
          ],
    );
  }
}
