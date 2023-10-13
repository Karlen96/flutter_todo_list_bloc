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
  final _todoBloc = TodoBloc();
  final _textEditingController = TextEditingController();

  void addItem() {
    _todoBloc.add(
      AddItem(
        title: _textEditingController.text,
      ),
    );
    _textEditingController.clear();
    Navigator.pop(context);
  }

  void _openAddModal() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return AddToDoModal(
          addItem: addItem,
          textEditingController: _textEditingController,
        );
      },
    );
  }

  void _onChanged(bool? value, TodoEntity item) {
    _todoBloc.add(
      UpdateItem(
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
    _todoBloc.add(
      RemoveItem(id: id),
    );
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocProvider<TodoBloc>(
        create: (context) => _todoBloc,
        child: BlocBuilder<TodoBloc, ToDoBloc>(
          builder: (context, state) {
            if (state is ToDoBlocInitial) {
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: state.todoList.length,
                separatorBuilder: (_, i) => const Divider(),
                itemBuilder: (_, i) => Dismissible(
                  key: ValueKey(i),
                  confirmDismiss: (_) => _confirmDismiss(
                    _,
                    state.todoList[i].id,
                  ),
                  child: ListTile(
                    title: Text(state.todoList[i].title),
                    trailing: Checkbox(
                      value: state.todoList[i].isDone,
                      onChanged: (_) => _onChanged(
                        _,
                        state.todoList[i],
                      ),
                    ),
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
