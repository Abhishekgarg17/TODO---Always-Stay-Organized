import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

enum TaskType { DUE_TODAY, UPCOMING, DELAYED, DONE }

@JsonSerializable()
class TaskModel extends ChangeNotifier {
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

  //Assigns Random Id like TaskType.UPCOMING_2119256580
  void assignId() {
    int max = 1 << 32;
    String gen = "${taskType}_${Random().nextInt(max)}";
    this.id = gen;
  }
}
