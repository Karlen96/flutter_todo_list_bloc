import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../entities/todo_entity.dart';
import 'todo_events.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, ToDoState> {
  TodoBloc() : super(ToDoInitialState()) {
    on<AddItemEvent>(_addItem);
    on<AddAllItemEvent>(_addAllItem);
    on<UpdateItemEvent>(_updateItem);
    on<RemoveItemEvent>(_removeItem);
  }

  final todoList = <TodoEntity>[];

  void _addItem(
    AddItemEvent event,
    Emitter<ToDoState> emit,
  ) {
    emit(ToDoLoadingState());
    emit(
      ToDoItemAddedState(
        newList: todoList
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
    AddAllItemEvent event,
    Emitter<ToDoState> emit,
  ) {
    emit(ToDoLoadingState());
    emit(
      ToDoAllItemAddedState(
        newList: todoList
          ..addAll(
            event.items,
          ),
      ),
    );
  }

  void _removeItem(
    RemoveItemEvent event,
    Emitter<ToDoState> emit,
  ) {
    emit(ToDoLoadingState());
    emit(
      ToDoItemUpdatedState(
        newList: todoList
          ..removeWhere(
            (e) => e.id == event.id,
          ),
      ),
    );
  }

  void _updateItem(
    UpdateItemEvent event,
    Emitter<ToDoState> emit,
  ) {
    final state = this.state;
    final index = todoList.indexWhere((e) => e.id == event.item.id);
    if (!index.isNegative) {
      todoList[index] = event.item;
    }
    emit(ToDoLoadingState());
    emit(
      ToDoItemUpdatedState(newList: todoList),
    );
  }
}
