import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/ui/styles/colors.dart';
import 'package:todo_app/utils/globals.dart';
import 'package:todo_app/utils/routes.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentindex,
      backgroundColor: Colors.amber,
      selectedFontSize: 16.0,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[200],
      selectedIconTheme: IconThemeData(size: 35),
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      items: [
        new BottomNavigationBarItem(
            icon: Icon(Icons.home), label: "Home", backgroundColor: baseColor),
        new BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/to-do-icon.png"),
            ),
            label: "Todo",
            backgroundColor: baseColor),
        new BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/delayed-icon.png"),
            ),
            label: "Delayed",
            backgroundColor: baseColor),
        new BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/upcoming-icon.png"),
            ),
            label: "Upcoming",
            backgroundColor: baseColor),
        new BottomNavigationBarItem(
            icon: Icon(Icons.done), label: "Done", backgroundColor: baseColor),
      ],
      onTap: (pos) {
        switch (pos) {
          case 0:
            {
              setState(() {
                currentindex = 0;
                bottomNavigator.currentState
                    .pushReplacementNamed(Routes.summary);
              });
              break;
            }
          case 1:
            {
              setState(() {
                currentindex = 1;
                bottomNavigator.currentState.pushReplacementNamed(
                    Routes.taskScreen,
                    arguments: TaskType.DUE_TODAY);
              });
              break;
            }
          case 2:
            {
              setState(() {
                currentindex = 2;
                bottomNavigator.currentState.pushReplacementNamed(
                    Routes.taskScreen,
                    arguments: TaskType.DELAYED);
              });
              break;
            }
          case 3:
            {
              setState(() {
                currentindex = 3;
                bottomNavigator.currentState.pushReplacementNamed(
                    Routes.taskScreen,
                    arguments: TaskType.UPCOMING);
              });
              break;
            }
          case 4:
            {
              setState(() {
                currentindex = 4;
                bottomNavigator.currentState.pushReplacementNamed(
                    Routes.taskScreen,
                    arguments: TaskType.DONE);
              });
              break;
            }
          default:
            {
              setState(() {
                currentindex = 0;
                bottomNavigator.currentState
                    .pushReplacementNamed(Routes.summary);
              });
            }
        }
      },
    );
  }
}
