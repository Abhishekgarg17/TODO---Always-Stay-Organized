import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/ui/styles/text_styles.dart';
import 'package:todo_app/ui/widgets/form_bottomsheet.dart';
import 'package:todo_app/ui/widgets/task_card.dart';
import 'package:todo_app/utils/database_helper.dart';

class TaskScreen extends StatefulWidget {
  final TaskType type;
  final List dataList;

  const TaskScreen({Key key, this.type, this.dataList}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String headingText;

  @override
  Widget build(BuildContext context) {
    headingText = getHeading(widget.type);
    return (widget.dataList == null || widget.dataList?.length == 0)
        ? Container()
        : Consumer<DatabaseHelper>(
            builder: (BuildContext context, value, Widget child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: value.getListByType(widget.type).length + 1,
                itemBuilder: (context, index) {
                  if (index == 0)
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        headingText,
                        style: cardTextStyle(),
                      ),
                    );
                  else
                    return TaskCard(
                      taskModel: value.getListByType(widget.type)[index - 1],
                      edit: () =>
                          openForm(value.getListByType(widget.type)[index - 1]),
                      delete: () => deleteDataFromList(
                          value.getListByType(widget.type)[index - 1]),
                      done: () => markAsDone(
                          value.getListByType(widget.type)[index - 1]),
                    );
                },
              );
            },
          );
  }

  openForm(TaskModel taskModel) {
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

  deleteDataFromList(TaskModel taskModel) {
    Provider.of<DatabaseHelper>(context, listen: false).deleteTask(taskModel);
  }

  markAsDone(TaskModel taskModel) {
    Provider.of<DatabaseHelper>(context, listen: false)
        .updateTask(taskModel, done: true);
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
}
