import 'package:flutter/material.dart';

import 'package:todo_app/home.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      theme: ThemeData(
        primaryColor: Colors.yellow
      ),
      home: Home(),
    );
  }
}