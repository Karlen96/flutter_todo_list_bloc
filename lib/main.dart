import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_bloc/sceens/todo_screen.dart';
import 'package:flutter_todo_list_bloc/state/todo/todo_bloc.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (_) => TodoBloc(),
      child: const MaterialApp(
        home: TodoListScreen(),
      ),
    );
  }
}
