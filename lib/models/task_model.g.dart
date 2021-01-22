// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return TaskModel(
    id: json['id'] as String,
    title: json['title'] as String,
    details: json['details'] as String,
    deadlineDate: json['deadlineDate'] == null
        ? null
        : DateTime.parse(json['deadlineDate'] as String),
    taskType: _$enumDecodeNullable(_$TaskTypeEnumMap, json['taskType']),
  );
}

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'details': instance.details,
      'deadlineDate': instance.deadlineDate?.toIso8601String(),
      'taskType': _$TaskTypeEnumMap[instance.taskType],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TaskTypeEnumMap = {
  TaskType.DUE_TODAY: 'DUE_TODAY',
  TaskType.UPCOMING: 'UPCOMING',
  TaskType.DELAYED: 'DELAYED',
  TaskType.DONE: 'DONE',
};
