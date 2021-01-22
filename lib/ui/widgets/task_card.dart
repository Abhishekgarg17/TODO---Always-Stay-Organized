import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/ui/styles/colors.dart';
import 'package:todo_app/ui/styles/text_styles.dart';

class TaskCard extends StatelessWidget {
  final TaskModel taskModel;
  final VoidCallback edit;
  final VoidCallback delete;
  final VoidCallback done;

  const TaskCard({Key key, this.taskModel, this.edit, this.delete, this.done})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Card(
        elevation: 7,
        shadowColor: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        taskModel.title,
                        style: cardHeadingTextStyle(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          taskModel.details,
                          style: cardSubHeading2TextStyle(),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      getDateWidget(),
                      (taskModel.taskType == TaskType.DONE)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: iconColor,
                                  ),
                                  onPressed: delete,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: iconColor,
                                  ),
                                  onPressed: edit,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: iconColor,
                                  ),
                                  onPressed: delete,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.done_outline_rounded,
                                    color: iconColor,
                                  ),
                                  onPressed: done,
                                ),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDateWidget() {
    if (taskModel.taskType == TaskType.DUE_TODAY ||
        taskModel.taskType == TaskType.DONE)
      return Container();
    else if (taskModel.taskType == TaskType.DELAYED)
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.timer_off,
            color: iconColor,
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            "Was Due on " + formatDate(taskModel.deadlineDate),
            style: cardSubHeading3TextStyle(),
          )
        ],
      );
    else if ((taskModel.taskType == TaskType.UPCOMING)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.timer,
            color: iconColor,
          ),
          SizedBox(
            width: 7,
          ),
          Text(
            "Due on " + formatDate(taskModel.deadlineDate),
            style: cardSubHeading4TextStyle(),
          )
        ],
      );
    } else
      return Container();
  }

  String formatDate(DateTime dt) {
    return dt.day.toString() +
        "-" +
        dt.month.toString() +
        "-" +
        dt.year.toString();
  }
}
