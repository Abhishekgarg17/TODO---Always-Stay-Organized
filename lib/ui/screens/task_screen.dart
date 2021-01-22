import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/ui/styles/colors.dart';
import 'package:todo_app/ui/styles/text_styles.dart';
import 'package:todo_app/ui/widgets/form_bottomsheet.dart';
import 'package:todo_app/ui/widgets/task_card.dart';
import 'package:todo_app/utils/globals.dart';
import 'package:todo_app/utils/shared_pref_manager.dart';

class TaskScreen extends StatefulWidget {
  final TaskType type;

  const TaskScreen({Key key, this.type}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List dataList;
  String headingText;

  @override
  void initState() {
    super.initState();
    headingText = getHeading(widget.type);
    dataList = getListByType(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
              child: new Text(
                headingText ?? "",
                style: headingTextStyle(),
              ),
            ),
            (dataList.length == 0)
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0),
                      child: ListView(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/list-is-empty.png',
                            width: MediaQuery.of(context).size.width * 0.55,
                            height: MediaQuery.of(context).size.width * 0.55,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "No Tasks Posted",
                            textAlign: TextAlign.center,
                            style: cardHeadingTextStyle(),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) => TaskCard(
                          taskModel: dataList[index],
                          edit: () => openForm(dataList[index]),
                          delete: () => deleteDataFromList(dataList[index]),
                          done: () => markAsDone(dataList[index]),
                        ),
                      ),
                    ),
                  )
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () => openForm(new TaskModel()),
          elevation: 5,
          foregroundColor: Colors.white,
          backgroundColor: baseColor,
          child: Container(
            child: Icon(Icons.add, size: 30),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
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
    ).then((_) {
      setState(() {});
    });
  }

  deleteDataFromList(TaskModel taskModel) {
    SharedPreferenceManager sf = new SharedPreferenceManager();
    List<TaskModel> temp = getListByType(taskModel.taskType);
    TaskType tp = taskModel.taskType;

    for (int i = 0; i < temp.length; i++) {
      if (taskModel.id == temp[i].id) {
        getListByType(tp).remove(temp[i]);
        decrementCount(tp);
        sf.removeFromSF(tp);
        sf.addToSF(temp, tp);
        break;
      }
    }
    setState(() {});
  }

  List<Widget> dummy = [
    TaskCard(
      taskModel: new TaskModel(
        title: "Shopping",
        details:
            "Shop on Grofers and 1mg and bigbasket Shop on Grofers and 1mg and bigbasket Shop on Grofers and 1mg and bigbasket",
        deadlineDate: DateTime.now(),
        taskType: TaskType.DUE_TODAY,
      ),
    ),
    TaskCard(
      taskModel: new TaskModel(
        title: "Shopping",
        details:
            "Shop on Grofers and 1mg and bigbasket Shop on Grofers and 1mg and bigbasket Shop on Grofers and 1mg and bigbasket",
        deadlineDate: DateTime.now(),
        taskType: TaskType.DONE,
      ),
    ),
    TaskCard(
      taskModel: new TaskModel(
        title: "Shopping",
        details:
            "Shop on Grofers and 1mg and bigbasket Shop on Grofers and 1mg and bigbasket Shop on Grofers and 1mg and bigbasket",
        deadlineDate: DateTime.now(),
        taskType: TaskType.DELAYED,
      ),
    ),
    TaskCard(
      taskModel: new TaskModel(
        title: "Shopping",
        details:
            "Shop on Grofers and 1mg and bigbasket Shop on Grofers and 1mg and bigbasket Shop on Grofers and 1mg and bigbasket",
        deadlineDate: DateTime.now(),
        taskType: TaskType.UPCOMING,
      ),
    )
  ];

  markAsDone(TaskModel taskModel) {
    SharedPreferenceManager sfm = new SharedPreferenceManager();

    //Remove from old list
    deleteDataFromList(taskModel);

    //Update State and add to new list
    taskModel.taskType = TaskType.DONE;
    getListByType(taskModel.taskType).add(taskModel);
    incrementCount(taskModel.taskType);
    sfm.addToSF(getListByType(TaskType.DONE), TaskType.DONE);

    setState(() {});
  }
}
