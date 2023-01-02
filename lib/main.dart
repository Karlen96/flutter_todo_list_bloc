import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/todo_screen.dart';
import 'state/todo/todo_bloc.dart';

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
