import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/task_count_card.dart';

class SummaryWidget extends StatelessWidget {
  final int dueTodayCount;
  final int delayedCount;
  final int upcomingCount;
  final int doneCount;

  const SummaryWidget(
      this.dueTodayCount, this.delayedCount, this.upcomingCount, this.doneCount,
      {Key key})
      : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TaskCountCard(
            color: Colors.blue,
            type: "Due Today",
            count: dueTodayCount,
          ),
          TaskCountCard(
            color: Colors.red,
            type: "Delayed",
            count: delayedCount,
          ),
          TaskCountCard(
            color: Colors.amber[900],
            type: "Upcoming",
            count: upcomingCount,
          ),
          TaskCountCard(
            color: Colors.green[900],
            type: "Completed",
            count: doneCount,
          ),
        ],
      ),
    );
  }
}
