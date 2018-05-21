import 'package:flutter/material.dart';
import 'package:todo_vanilla_redux/todos_repository_flutter/file_storege.dart';
import 'package:todo_vanilla_redux/todos_repository_flutter/repository.dart';
import 'package:todo_vanilla_redux/vanilla/app.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(vanillaApp());

Widget vanillaApp() {
  return VanillaApp(
    repository: TodosRepositoryFlutter(
        fileStorage: new FileStorage(
      "vanilla_app",
      getApplicationDocumentsDirectory,
    )),
  );
}
