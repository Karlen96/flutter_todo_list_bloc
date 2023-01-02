// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoEntity _$$_TodoEntityFromJson(Map json) => _$_TodoEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      isDone: json['is_done'] as bool? ?? false,
    );

Map<String, dynamic> _$$_TodoEntityToJson(_$_TodoEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'is_done': instance.isDone,
    };
