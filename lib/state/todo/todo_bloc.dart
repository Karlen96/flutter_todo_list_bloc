import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_bloc/entities/todo_entity.dart';
import 'package:flutter_todo_list_bloc/state/todo/todo_events.dart';
import 'package:flutter_todo_list_bloc/state/todo/todo_state.dart';
import 'package:uuid/uuid.dart';

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
    final state = this.state;
    emit(
      ToDoState(
        todoList: List.from(state.todoList)
          ..add(
            TodoEntity(
              id: Uuid().v4(),
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
      ToDoState(
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
      ToDoState(
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
      ToDoState(
        todoList: List.from(state.todoList),
      ),
    );
  }
}
