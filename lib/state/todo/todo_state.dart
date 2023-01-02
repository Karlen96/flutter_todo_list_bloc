import '../../entities/todo_entity.dart';

class ToDoState {
  const ToDoState({
    this.todoList = const <TodoEntity>[],
  });

  final List<TodoEntity> todoList;

  ToDoState copyWith({
    List<TodoEntity>? todoList,
  }) {
    return ToDoState(
      todoList: todoList ?? this.todoList,
    );
  }
}
