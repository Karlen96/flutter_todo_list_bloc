import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/todo_entity.dart';
import '../state/todo/todo_bloc.dart';
import '../state/todo/todo_events.dart';
import '../state/todo/todo_state.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final _textEditingController = TextEditingController();

  void addItem() {
    context.read<TodoBloc>().add(
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
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'To do title',
                ),
              ),
              ElevatedButton(
                child: const Text('add to do'),
                onPressed: addItem,
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
    context.read<TodoBloc>().add(
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
    context.read<TodoBloc>().add(
          RemoveItem(id: id),
        );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: BlocBuilder<TodoBloc, ToDoState>(
        builder: (context, state) {
          return ListView.separated(
            padding: EdgeInsets.all(12),
            itemCount: state.todoList.length,
            separatorBuilder: (_, i) => Divider(),
            itemBuilder: (_, i) => Dismissible(
              key: ValueKey(i),
              confirmDismiss: (_) => _confirmDismiss(
                _,
                state.todoList[i].id,
              ),
              child: ListTile(
                title: Text('${state.todoList[i].title}'),
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
