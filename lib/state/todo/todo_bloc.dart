import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../entities/todo_entity.dart';
import 'todo_events.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, ToDoBloc> {
  TodoBloc() : super(const ToDoBlocInitial()) {
    on<AddItem>(_addItem);
    on<UpdateItem>(_updateItem);
    on<RemoveItem>(_removeItem);
  }

  void _addItem(
    AddItem event,
    Emitter<ToDoBloc> emit,
  ) {
    final _toDoList = [
      ...(state as ToDoBlocInitial).todoList,
      TodoEntity(
        id: const Uuid().v4(),
        title: event.title,
      ),
    ];

    emit(
      ToDoBlocInitial(
        todoList: _toDoList,
      ),
    );
  }

  void _removeItem(
    RemoveItem event,
    Emitter<ToDoBloc> emit,
  ) {
    final _toDoList = (state as ToDoBlocInitial).todoList
      ..removeWhere(
        (e) => e.id == event.id,
      );

    emit(
      ToDoBlocInitial(
        todoList: _toDoList,
      ),
    );
  }

  void _updateItem(
    UpdateItem event,
    Emitter<ToDoBloc> emit,
  ) {
    final _todoList = (state as ToDoBlocInitial).todoList;
    final index = _todoList.indexWhere((e) => e.id == event.item.id);
    if (!index.isNegative) {
      _todoList[index] = event.item;
    }
    emit(
      ToDoBlocInitial(
        todoList: _todoList,
      ),
    );
  }
}
