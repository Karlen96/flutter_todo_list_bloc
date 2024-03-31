import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/todo_entity.dart';
import '../state/todo/todo_bloc.dart';
import '../state/todo/todo_events.dart';
import '../state/todo/todo_state.dart';
import '../widgets/modals/add_todo_modal.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  void addItem(String title) {
    context.read<TodoBloc>().add(
          AddItemEvent(title: title),
        );
  }

  Future<void> _openAddModal(BuildContext context) async {
    final res = await showModalBottomSheet<String?>(
      isScrollControlled: true,
      context: context,
      builder: (_) => const AddToDoModal(),
    );
    if (res != null && res.trim().isNotEmpty) {
      addItem(res.trim());
    }
  }

  void _onChanged(bool? value, TodoEntity item) {
    context.read<TodoBloc>().add(
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
    context.read<TodoBloc>().add(
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
          var todoList = <TodoEntity>[];

          if (state is ToDoItemAddedState) {
            todoList = state.newList;
          }
          if (state is ToDoItemRemovedState) {
            todoList = state.newList;
          }
          if (state is ToDoItemUpdatedState) {
            todoList = state.newList;
          }
          if (state is ToDoAllItemAddedState) {
            todoList = state.newList;
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: context.read<TodoBloc>().todoList.length,
            separatorBuilder: (_, i) => const Divider(),
            itemBuilder: (_, i) => Dismissible(
              key: ValueKey(i),
              confirmDismiss: (_) => _confirmDismiss(
                _,
                context.read<TodoBloc>().todoList[i].id,
              ),
              child: ListTile(
                title: Text(todoList[i].title),
                trailing: Checkbox(
                  value: todoList[i].isDone,
                  onChanged: (_) => _onChanged(
                    _,
                    todoList[i],
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
