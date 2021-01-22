import 'package:flutter/material.dart';
import 'package:todo_app/ui/styles/text_styles.dart';
import 'package:todo_app/ui/widgets/task_count_card.dart';
import 'package:todo_app/utils/globals.dart';

class SummaryScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 25, 10),
                child: new Text(
                  "Here's a summary for you",
                  style: headingTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TaskCountCard(
                    color: Colors.blue,
                    type: "Due Today",
                    count: dueTodayListCount,
                  ),
                  TaskCountCard(
                    color: Colors.red,
                    type: "Delayed",
                    count: delayedListCount,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TaskCountCard(
                    color: Colors.amber[900],
                    type: "Upcoming",
                    count: upcomingListCount,
                  ),
                  TaskCountCard(
                    color: Colors.green[900],
                    type: "Completed",
                    count: doneListCount,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
