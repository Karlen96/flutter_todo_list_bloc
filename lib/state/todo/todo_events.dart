import '../../entities/todo_entity.dart';

abstract class TodoEvent {}

/// Notifies bloc to add item.
class AddItemEvent extends TodoEvent {
  final String title;

  AddItemEvent({
    required this.title,
  });
}

/// Notifies bloc to add all items.
class AddAllItemEvent extends TodoEvent {
  final List<TodoEntity> items;

  AddAllItemEvent({
    required this.items,
  });
}

/// Notifies bloc to add all items.
class UpdateItemEvent extends TodoEvent {
  final TodoEntity item;

  UpdateItemEvent({
    required this.item,
  });
}

/// Notifies bloc to remove item.
class RemoveItemEvent extends TodoEvent {
  final String id;

  RemoveItemEvent({
    required this.id,
  });
}
