import '../../entities/todo_entity.dart';

abstract class ToDoState {}

class ToDoInitialState extends ToDoState {}

class ToDoLoadingState extends ToDoState {}

class ToDoItemAddedState extends ToDoState {
  final List<TodoEntity> newList;

  ToDoItemAddedState({
    required this.newList,
  }) : super();
}

class ToDoAllItemAddedState extends ToDoState {
  final List<TodoEntity> newList;

  ToDoAllItemAddedState({
    required this.newList,
  }) : super();
}

class ToDoItemUpdatedState extends ToDoState {
  final List<TodoEntity> newList;

  ToDoItemUpdatedState({
    required this.newList,
  }) : super();
}

class ToDoItemRemovedState extends ToDoState {
  final List<TodoEntity> newList;

  ToDoItemRemovedState({
    required this.newList,
  }) : super();
}
