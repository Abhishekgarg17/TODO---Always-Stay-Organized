import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/utils/shared_pref_manager.dart';

final bottomNavigator = GlobalKey<NavigatorState>(debugLabel: "bottomBarNav");
int currentindex = 0;

List<TaskModel> dueTodayList = new List<TaskModel>();
List<TaskModel> delayedList = new List<TaskModel>();
List<TaskModel> upcomingList = new List<TaskModel>();
List<TaskModel> doneList = new List<TaskModel>();

int dueTodayListCount = 0;
int delayedListCount = 0;
int upcomingListCount = 0;
int doneListCount = 0;

List getListByType(TaskType tp) {
  if (tp == TaskType.DUE_TODAY) {
    return dueTodayList;
  } else if (tp == TaskType.DELAYED) {
    sortList(delayedList);
    return delayedList;
  } else if (tp == TaskType.UPCOMING) {
    sortList(upcomingList);
    return upcomingList;
  } else if (tp == TaskType.DONE) {
    return doneList;
  } else {
    sortList(dueTodayList);
    return dueTodayList;
  }
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

String getHeading(TaskType tp) {
  if (tp == TaskType.DUE_TODAY) {
    return "Due Today";
  } else if (tp == TaskType.DELAYED) {
    return "Delayed";
  } else if (tp == TaskType.UPCOMING) {
    return "Upcoming";
  } else if (tp == TaskType.DONE) {
    return "Completed";
  } else {
    return "";
  }
}

void sortList(List list) {
  list.sort((a, b) => (a.deadlineDate).compareTo(b.deadlineDate));
}

// Checks the status of tasks with respect to today's date
// and updates the list accordingly.
void checkStatusWrtToday() {
  SharedPreferenceManager spm = new SharedPreferenceManager();
  DateTime curr = new DateTime.now();
  DateTime today = new DateTime(curr.year, curr.month, curr.day);

  for (int i = dueTodayList.length - 1; i >= 0; i--) {
    if (dueTodayList[i].deadlineDate.isBefore(today)) {
      // Move from due today to delayed
      dueTodayList[i].taskType = TaskType.DELAYED;
      delayedList.add(dueTodayList[i]);
      dueTodayList.remove(dueTodayList[i]);
    }
  }

  for (int i = upcomingList.length - 1; i >= 0; i--) {
    if (upcomingList[i].deadlineDate.isAtSameMomentAs(today)) {
      //Move from upcoming to due today
      upcomingList[i].taskType = TaskType.DUE_TODAY;
      dueTodayList.add(upcomingList[i]);
      upcomingList.remove(upcomingList[i]);
    }
  }
  spm.addToSF(delayedList, TaskType.DELAYED);
  spm.addToSF(dueTodayList, TaskType.DUE_TODAY);
  spm.addToSF(upcomingList, TaskType.UPCOMING);
}
