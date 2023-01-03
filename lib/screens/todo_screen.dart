import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/todo_entity.dart';
import '../state/todo/todo_bloc.dart';
import '../state/todo/todo_events.dart';
import '../state/todo/todo_state.dart';

class TodoListScreen extends StatelessWidget {
  final _textEditingController = TextEditingController();

  final TodoBloc todoBloc = TodoBloc();

  TodoListScreen({super.key});

  void addItem(BuildContext context) {
    todoBloc.add(
      AddItemEvent(
        title: _textEditingController.text,
      ),
    );
    _textEditingController.clear();
    Navigator.pop(context);
  }

  void _openAddModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textEditingController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'To do title',
                ),
              ),
              ElevatedButton(
                onPressed: () => addItem(context),
                child: const Text('add to do'),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onChanged(bool? value, TodoEntity item) {
    todoBloc.add(
      UpdateItemEvent(
        item: item.copyWith(
          isDone: value ?? false,
        ),
      ),
    );
  }

  Future<bool?> _confirmDismiss(
    DismissDirection direction,
    String id,
  ) async {
    todoBloc.add(
      RemoveItemEvent(id: id),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocBuilder<TodoBloc, ToDoState>(
        builder: (context, state) {
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: todoBloc.todoList.length,
            separatorBuilder: (_, i) => const Divider(),
            itemBuilder: (_, i) => Dismissible(
              key: ValueKey(i),
              confirmDismiss: (_) => _confirmDismiss(
                _,
                todoBloc.todoList[i].id,
              ),
              child: ListTile(
                title: Text(todoBloc.todoList[i].title),
                trailing: Checkbox(
                  value: todoBloc.todoList[i].isDone,
                  onChanged: (_) => _onChanged(
                    _,
                    todoBloc.todoList[i],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
