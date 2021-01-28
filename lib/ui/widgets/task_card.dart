import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: getCardColorByTaskType(taskModel.taskType),
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  taskModel.title ?? "Your Task",
                  style: cardTextStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 7, 0, 10),
                child: getDateWidget(),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Text(
                      taskModel?.details ?? "No Details Present",
                      style: cardSubHeadingTextStyle(),
                    ),
                  ),
                  (taskModel.taskType == TaskType.DONE)
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: delete,
                        )
                      : PopupMenuButton<String>(
                          onSelected: handleClick,
                          itemBuilder: (BuildContext context) {
                            return {'Edit', 'Delete', 'Mark as Done'}
                                .map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getCardColorByTaskType(TaskType tp) {
    if (tp == TaskType.DUE_TODAY) {
      return Colors.blue[50];
    } else if (tp == TaskType.DELAYED) {
      return Colors.red[50];
    } else if (tp == TaskType.UPCOMING) {
      return Colors.orange[100];
    } else if (tp == TaskType.DONE) {
      return Colors.green[200];
    } else
      return Colors.white;
  }

  Widget getDateWidget() {
    if (taskModel.taskType == TaskType.DONE)
      return Container();
    else if (taskModel.taskType == TaskType.DUE_TODAY)
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.timelapse,
            color: iconColor,
            size: 18,
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            "Due at " + DateFormat('hh:mm a').format(taskModel.deadlineDate),
            style: upcomingDateTextStyle(),
          )
        ],
      );
    else if (taskModel.taskType == TaskType.DELAYED)
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.timer_off,
            color: iconColor,
            size: 18,
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            "Was Due on " +
                DateFormat('dd-MM-yyyy  hh:mm a')
                    .format(taskModel.deadlineDate),
            style: delayedDateTextStyle(),
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
            size: 18,
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            "Due " +
                DateFormat('dd-MM-yyyy  hh:mm a')
                    .format(taskModel.deadlineDate),
            style: upcomingDateTextStyle(),
          )
        ],
      );
    } else
      return Container();
  }

  void handleClick(String value) {
    switch (value) {
      case 'Edit':
        {
          edit();
          break;
        }
      case 'Delete':
        {
          delete();
          break;
        }
      case 'Mark as Done':
        {
          done();
          break;
        }
    }
  }
}
