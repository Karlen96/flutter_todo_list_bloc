import '../../entities/todo_entity.dart';

abstract class TodoEvent {}

/// Notifies bloc to add item.
class AddItem extends TodoEvent {
  final String title;

  AddItem({
    required this.title,
  });
}

/// Notifies bloc to add all items.
class AddAllItem extends TodoEvent {
  final List<TodoEntity> items;

  AddAllItem({
    required this.items,
  });
}

/// Notifies bloc to add all items.
class UpdateItem extends TodoEvent {
  final TodoEntity item;

  UpdateItem({
    required this.item,
  });
}

/// Notifies bloc to remove item.
class RemoveItem extends TodoEvent {
  final String id;

  RemoveItem({
    required this.id,
  });
}
