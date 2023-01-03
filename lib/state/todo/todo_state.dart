abstract class ToDoState {}

class ToDoInitialState extends ToDoState {}

class ToDoLoadingState extends ToDoState {}

class ToDoItemAddedState extends ToDoState {
  final List newList;

  ToDoItemAddedState({
    required this.newList,
  }) : super();
}

class ToDoAllItemAddedState extends ToDoState {
  final List newList;

  ToDoAllItemAddedState({
    required this.newList,
  }) : super();
}

class ToDoItemUpdatedState extends ToDoState {
  final List newList;

  ToDoItemUpdatedState({
    required this.newList,
  }) : super();
}

class ToDoItemRemovedState extends ToDoState {
  final List newList;

  ToDoItemRemovedState({
    required this.newList,
  }) : super();
}
