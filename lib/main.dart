import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/controller/todo_controller.dart';
import 'package:todoapp/models/todo_model.dart';

import 'view/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoItemAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final TodoService _todoService = TodoService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: _todoService.getAllTodos(),
          builder:
              (BuildContext context, AsyncSnapshot<List<TodoItem>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return TodoListPage(snapshot.data ?? []);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}
