import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/ui/screens/summary_widget.dart';
import 'package:todo_app/ui/screens/task_screen.dart';
import 'package:todo_app/ui/styles/colors.dart';
import 'package:todo_app/ui/widgets/form_bottomsheet.dart';
import 'package:todo_app/utils/database_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Todo - Always Stay Organized",
          ),
        ),
        body: Consumer<DatabaseHelper>(
          builder: (BuildContext context, value, Widget child) {
            return ListView(
              shrinkWrap: true,
              children: <Widget>[
                SummaryWidget(
                  value.dueTodayListCount,
                  value.delayedListCount,
                  value.upcomingListCount,
                  value.doneListCount,
                ),
                TaskScreen(
                  type: TaskType.DUE_TODAY,
                  dataList: value.dueTodayList,
                ),
                TaskScreen(
                  type: TaskType.DELAYED,
                  dataList: value.delayedList,
                ),
                TaskScreen(
                  type: TaskType.UPCOMING,
                  dataList: value.upcomingList,
                ),
                TaskScreen(
                  type: TaskType.DONE,
                  dataList: value.doneList,
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            );
          },
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () => openForm(new TaskModel(), context),
          elevation: 5,
          foregroundColor: Colors.white,
          backgroundColor: baseColor,
          child: Icon(Icons.add, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void openForm(TaskModel taskModel, BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (BuildContext context) {
        return FormBottomSheet(taskModel: taskModel);
      },
    );
  }
}
