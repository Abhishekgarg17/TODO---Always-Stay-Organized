import 'dart:core';
import 'dart:math';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

enum TaskType { DUE_TODAY, UPCOMING, DELAYED, DONE }

@JsonSerializable()
class TaskModel {
  String id;
  String title;
  String details;
  DateTime deadlineDate;
  TaskType taskType;

  TaskModel({
    this.id,
    this.title,
    this.details,
    this.deadlineDate,
    this.taskType,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  //Assigns Random Id
  void assignId() {
    int max = 1 << 32;
    String gen = "${Random().nextInt(max)}";
    this.id = gen;
  }

  void updateDueState() {
    DateTime curr = new DateTime.now();

    if (isBefore(this.deadlineDate, curr))
      this.taskType = TaskType.DELAYED;
    else if (_isSameDay(this.deadlineDate, curr))
      this.taskType = TaskType.DUE_TODAY;
    else
      this.taskType = TaskType.UPCOMING;
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1?.year == d2?.year && d1?.month == d2?.month && d1?.day == d2?.day;
  }

  bool isBefore(DateTime d1, DateTime d2) {
    if (d1 != null && d2 != null) {
      if (d1.year < d2.year)
        return true;
      else if (d1.year > d2.year)
        return false;
      else if (d1.year == d2.year) {
        if (d1.month < d2.month)
          return true;
        else if (d1.month > d2.month)
          return false;
        else if (d1.month == d2.month) {
          if (d1.day < d2.day)
            return true;
          else if (d1.day > d2.day) return false;
        }
      }
    }
    return false;
  }
}
