import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/utils/sqlite_manager.dart';

// Helper Class to connect the database and UI
class DatabaseHelper extends ChangeNotifier {
  final SqliteManager sqliteManager;

  List<TaskModel> dueTodayList = new List<TaskModel>();
  List<TaskModel> delayedList = new List<TaskModel>();
  List<TaskModel> upcomingList = new List<TaskModel>();
  List<TaskModel> doneList = new List<TaskModel>();

  int dueTodayListCount = 0;
  int delayedListCount = 0;
  int upcomingListCount = 0;
  int doneListCount = 0;

  DatabaseHelper(this.dueTodayList, this.delayedList, this.upcomingList,
      this.doneList, this.sqliteManager) {
    if (sqliteManager != null) {
      fetchAndInitData();
    }
  }

  Future<void> fetchAndInitData() async {
    if (sqliteManager.db != null) {
      //Due Today List
      final dataList = await sqliteManager.getTasksfromDb(TaskType.DUE_TODAY) ??
          new List<TaskModel>();
      dueTodayList = List.from(dataList);
      dueTodayListCount = dueTodayList.length;

      //Delayed List
      final dataList1 = await sqliteManager.getTasksfromDb(TaskType.DELAYED) ??
          new List<TaskModel>();
      delayedList = List.from(dataList1);
      delayedListCount = delayedList.length;

      //Upcoming List
      final dataList2 = await sqliteManager.getTasksfromDb(TaskType.UPCOMING) ??
          new List<TaskModel>();
      upcomingList = List.from(dataList2);
      upcomingListCount = upcomingList.length;

      //Done List
      final dataList3 = await sqliteManager.getTasksfromDb(TaskType.DONE) ??
          new List<TaskModel>();
      doneList = List.from(dataList3);
      doneListCount = doneList.length;

      updateTasksWrtTime(TaskType.DUE_TODAY);
      updateTasksWrtTime(TaskType.UPCOMING);

      notifyListeners();
    }
  }

  void addTask(TaskModel tm) {
    List<TaskModel> temp = getListByType(tm.taskType);
    if (sqliteManager.db != null) {
      temp.add(tm);
      incrementCount(tm.taskType);
      notifyListeners();
      sqliteManager.insertTaskToDb(tm);
    }
  }

  void deleteTask(TaskModel tm) {
    List<TaskModel> temp = getListByType(tm.taskType);
    if (sqliteManager.db != null) {
      temp.remove(tm);
      decrementCount(tm.taskType);
      notifyListeners();
      sqliteManager.removeTaskById(tm);
    }
  }

  void updateTask(TaskModel tm, {done = false}) {
    if (sqliteManager.db != null) {
      List<TaskModel> temp = getListByType(tm.taskType);

      for (int i = 0; i < temp.length; i++) {
        if (tm.id == temp[i].id) {
          //Remove from old list and decrement
          getListByType(tm.taskType).remove(tm);
          decrementCount(tm.taskType);
          //Update taskType according to new Details (if date or time changes)
          if (done)
            tm.taskType = TaskType.DONE;
          else
            tm.updateDueState();
          //Add to New list for changed task type and increment
          getListByType(tm.taskType).add(tm);
          incrementCount(tm.taskType);
          //Notify to UI
          notifyListeners();
          //Update in the Database
          sqliteManager.updateTaskInDb(tm);
          notifyListeners();
          break;
        }
      }
    }
  }

  List getListByType(TaskType tp) {
    if (tp == TaskType.DUE_TODAY)
      return dueTodayList;
    else if (tp == TaskType.DELAYED)
      return delayedList;
    else if (tp == TaskType.UPCOMING)
      return upcomingList;
    else if (tp == TaskType.DONE)
      return doneList;
    else
      return dueTodayList;
  }

  void incrementCount(TaskType tp) {
    if (tp == TaskType.DUE_TODAY) {
      dueTodayListCount++;
    } else if (tp == TaskType.DELAYED) {
      delayedListCount++;
    } else if (tp == TaskType.UPCOMING) {
      upcomingListCount++;
    } else if (tp == TaskType.DONE) {
      doneListCount++;
    }
  }

  void decrementCount(TaskType tp) {
    if (tp == TaskType.DUE_TODAY) {
      dueTodayListCount--;
    } else if (tp == TaskType.DELAYED) {
      delayedListCount--;
    } else if (tp == TaskType.UPCOMING) {
      upcomingListCount--;
    } else if (tp == TaskType.DONE) {
      doneListCount--;
    }
  }

  void updateTasksWrtTime(TaskType tp) async {
    if (sqliteManager.db != null) {
      List<TaskModel> temp = List.from(getListByType(tp));

      for (int i = 0; i < temp.length; i++) {
        TaskType oldTaskType = temp[i].taskType;
        temp[i].updateDueState();
        getListByType(oldTaskType).remove(temp[i]);
        decrementCount(tp);
        getListByType(tp).add(temp[i]);
        incrementCount(tp);
        sqliteManager.updateTaskInDb(temp[i], notify: false);
      }
    }
  }
}
