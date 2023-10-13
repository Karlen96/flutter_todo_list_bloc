import '../../entities/todo_entity.dart';

sealed class ToDoBloc {
  const ToDoBloc();
}

final class ToDoBlocInitial extends ToDoBloc {
  const ToDoBlocInitial({
    this.todoList = const <TodoEntity>[],
  });

  final List<TodoEntity> todoList;
}

final class ToDoBlocLoading extends ToDoBloc {}

final class ToDoBlocFailure extends ToDoBloc {}


