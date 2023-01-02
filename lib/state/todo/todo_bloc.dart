import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../entities/todo_entity.dart';
import 'todo_events.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, ToDoState> {
  TodoBloc() : super(const ToDoState()) {
    on<AddItem>(_addItem);
    on<AddAllItem>(_addAllItem);
    on<UpdateItem>(_updateItem);
    on<RemoveItem>(_removeItem);
  }

  void _addItem(
    AddItem event,
    Emitter<ToDoState> emit,
  ) {
    emit(
      state.copyWith(
        todoList: List.from(state.todoList)
          ..add(
            TodoEntity(
              id: const Uuid().v4(),
              title: event.title,
            ),
          ),
      ),
    );
  }

  void _addAllItem(
    AddAllItem event,
    Emitter<ToDoState> emit,
  ) {
    final state = this.state;
    emit(
      state.copyWith(
        todoList: List.from(state.todoList)
          ..addAll(
            event.items,
          ),
      ),
    );
  }

  void _removeItem(
    RemoveItem event,
    Emitter<ToDoState> emit,
  ) {
    final state = this.state;
    emit(
      state.copyWith(
        todoList: List.from(state.todoList)
          ..removeWhere(
            (e) => e.id == event.id,
          ),
      ),
    );
  }

  void _updateItem(
    UpdateItem event,
    Emitter<ToDoState> emit,
  ) {
    final state = this.state;
    final index = state.todoList.indexWhere((e) => e.id == event.item.id);
    if (!index.isNegative) {
      state.todoList[index] = event.item;
    }
    emit(
      state.copyWith(
        todoList: List.from(state.todoList),
      ),
    );
  }
}
