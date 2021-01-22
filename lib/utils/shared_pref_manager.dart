import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task_model.dart';

class SharedPreferenceManager {
  static String dueTodayListKey = "due_today_list";
  static String delayedListKey = "delayed_list";
  static String upcomingListKey = "upcoming_list";
  static String doneListKey = "done_list";

  void addToSF(List<TaskModel> list, TaskType type) async {
    SharedPreferences instance = await SharedPreferences.getInstance();

    String listKey = getListKeyByType(type);
    instance.setString(listKey, jsonEncode(list));
  }

  void removeFromSF(TaskType type) async {
    SharedPreferences instance = await SharedPreferences.getInstance();

    String listKey = getListKeyByType(type);
    instance.remove(listKey);
  }

  Future<List<TaskModel>> getFromSF(TaskType tp) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    //Get List
    String jsonList = instance.getString(getListKeyByType(tp));
    // Get Decoded List
    List<TaskModel> tempTaskList;
    if (jsonList != null) {
      Iterable itr = json.decode(jsonList);
      tempTaskList =
          List<TaskModel>.from(itr.map((model) => TaskModel.fromJson(model)));
    }

    return (tempTaskList != null) ? tempTaskList : null;
  }

  String getListKeyByType(TaskType tp) {
    if (tp == TaskType.DUE_TODAY) {
      return dueTodayListKey;
    } else if (tp == TaskType.DELAYED) {
      return delayedListKey;
    } else if (tp == TaskType.UPCOMING) {
      return upcomingListKey;
    } else if (tp == TaskType.DONE) {
      return doneListKey;
    } else {
      return dueTodayListKey;
    }
  }
}
