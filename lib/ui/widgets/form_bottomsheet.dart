import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/ui/styles/colors.dart';
import 'package:todo_app/ui/styles/text_styles.dart';
import 'package:todo_app/utils/globals.dart';
import 'package:todo_app/utils/shared_pref_manager.dart';

class FormBottomSheet extends StatefulWidget {
  final TaskModel taskModel;

  const FormBottomSheet({Key key, this.taskModel}) : super(key: key);

  @override
  _FormBottomSheetState createState() => _FormBottomSheetState();
}

class _FormBottomSheetState extends State<FormBottomSheet> {
  TextEditingController _titleCtl;
  TextEditingController _dateCtl;
  TextEditingController _detailsCtl;

  DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = widget.taskModel?.deadlineDate;

    _titleCtl = TextEditingController(text: widget.taskModel?.title ?? "");
    _dateCtl = TextEditingController(
        text: widget.taskModel?.deadlineDate
                ?.toIso8601String()
                ?.split('T')
                ?.elementAt(0) ??
            "");
    _detailsCtl = TextEditingController(text: widget.taskModel?.details ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                "Enter Task Details",
                style: cardHeadingTextStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
              child: TextFormField(
                controller: _titleCtl,
                decoration: formInputDecoration(
                  'Title',
                  Icons.person,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
              child: TextFormField(
                controller: _detailsCtl,
                decoration: formInputDecoration(
                  'Details',
                  Icons.label_important,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
              child: TextFormField(
                readOnly: true,
                controller: _dateCtl,
                decoration: formInputDecoration(
                  'Deadline Date',
                  Icons.date_range,
                ),
                onTap: () => _setDate(widget.taskModel),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              onPressed: () => submitData(),
              color: baseColor,
              child: Text(
                "Save Task",
                style: new TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _selectDate(BuildContext context, DateTime dt) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? dt ?? new DateTime.now(),
      firstDate: new DateTime.now(),
      lastDate: new DateTime(2050),
      locale: WidgetsBinding.instance.window.locale,
    );

    return picked;
  }

  void _setDate(TaskModel val) {
    DateTime currDate = new DateTime.now();
    _selectDate(context, val?.deadlineDate ?? currDate).then((pickedDate) {
      selectedDate = pickedDate;
      _dateCtl.text = pickedDate?.toIso8601String()?.split("T")?.elementAt(0);
    }).catchError((error) => debugPrint("DATE_ERROR : $error"));
  }

  void submitData() {
    if (_titleCtl.text.isEmpty ||
        _detailsCtl.text.isEmpty ||
        _dateCtl.text.isEmpty) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: const Text("Fields can be empty."),
        backgroundColor: Colors.red,
      ));
    } else {
      widget.taskModel.title = _titleCtl.text;
      widget.taskModel.details = _detailsCtl.text;
      widget.taskModel.deadlineDate = selectedDate;

      if (widget.taskModel.id == null) {
        updateDueState();
        widget.taskModel.assignId();
        addDatatoStorage();
      } else {
        updateTaskByID(widget.taskModel.id);
      }
      Navigator.pop(context);
    }
  }

  void updateDueState() {
    if (isSameDay(selectedDate, DateTime.now()))
      widget.taskModel.taskType = TaskType.DUE_TODAY;
    else
      widget.taskModel.taskType = TaskType.UPCOMING;
  }

  bool isSameDay(DateTime d1, DateTime d2) {
    return d1?.year == d2?.year && d1?.month == d2?.month && d1?.day == d2.day;
  }

  void addDatatoStorage() {
    SharedPreferenceManager sfm = new SharedPreferenceManager();
    TaskType tp = widget.taskModel.taskType;
    getListByType(tp).add(widget.taskModel);
    incrementCount(tp);
    sfm.addToSF(getListByType(tp), tp);
  }

  void updateTaskByID(String id) {
    SharedPreferenceManager sfm = new SharedPreferenceManager();
    TaskType tp = widget.taskModel.taskType;
    List<TaskModel> temp = List.from(getListByType(tp));

    for (int i = 0; i < temp.length; i++) {
      if (id == temp[i].id) {
        // Update Local list and sf after deleting element
        getListByType(tp).remove(temp[i]);
        decrementCount(tp);
        // if element shifts to another category preserve old list
        temp.remove(temp[i]);
        sfm.removeFromSF(tp);
        sfm.addToSF(temp, tp);

        // Update Due State and save updated task model to
        // local and sf
        updateDueState();
        addDatatoStorage();

        break;
      }
    }
  }
}
