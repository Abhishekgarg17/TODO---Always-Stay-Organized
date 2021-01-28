import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/ui/styles/colors.dart';
import 'package:todo_app/ui/styles/text_styles.dart';
import 'package:todo_app/utils/database_helper.dart';

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
  TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();

    selectedDate = widget.taskModel?.deadlineDate;
    selectedTime = (widget.taskModel?.deadlineDate == null)
        ? null
        : new TimeOfDay(
            hour: widget.taskModel?.deadlineDate?.hour,
            minute: widget.taskModel?.deadlineDate?.minute);

    _titleCtl = TextEditingController(text: widget.taskModel?.title ?? "");

    String initDateText = (widget.taskModel?.deadlineDate != null)
        ? DateFormat('dd-MM-yyyy hh:mm a')
            .format(widget.taskModel?.deadlineDate)
        : "";
    _dateCtl = TextEditingController(text: initDateText);
    _detailsCtl = TextEditingController(text: widget.taskModel?.details ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
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
                  style: cardTextStyle(),
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
                  keyboardType: TextInputType.multiline,
                  controller: _detailsCtl,
                  maxLines: null,
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
                    'Deadline Date and Time',
                    Icons.date_range,
                  ),
                  onTap: () => _selectDate(context, widget.taskModel),
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
      ),
    );
  }

  _selectDate(BuildContext context, TaskModel tm) async {
    // Get Date
    await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now(),
      lastDate: new DateTime(2050),
      locale: WidgetsBinding.instance.window.locale,
    ).then((pickedDate) async {
      // Get Time if date is selected otherwise not
      if (pickedDate != null) {
        selectedDate = pickedDate;
        await showTimePicker(
          context: context,
          initialTime: selectedTime ?? new TimeOfDay.now(),
        ).then((pickedTime) {
          (pickedTime != null)
              ? selectedTime = pickedTime
              : throw new UnsupportedError("Time Not Selected");
        }).catchError((error) => debugPrint("TIME_ERROR : $error"));
      } else {
        throw new UnsupportedError("Date Not Selected");
      }
    }).catchError((error) => debugPrint("DATE_ERROR : $error"));

    _dateCtl.text = (selectedDate != null && selectedTime != null)
        ? DateFormat('dd-MM-yyyy').format(selectedDate) +
            "  " +
            selectedTime.format(context)
        : "";
  }

  void submitData() async {
    if (_titleCtl.text.isEmpty ||
        _detailsCtl.text.isEmpty ||
        _dateCtl.text.isEmpty) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: const Text("Fields can't be empty."),
        backgroundColor: Colors.red,
      ));
    } else {
      widget.taskModel.title = _titleCtl.text;
      widget.taskModel.details = _detailsCtl.text;
      DateTime temp = new DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      widget.taskModel.deadlineDate = temp;

      if (widget.taskModel.id == null) {
        widget.taskModel.updateDueState();
        widget.taskModel.assignId();
        Provider.of<DatabaseHelper>(context, listen: false)
            .addTask(widget.taskModel);
      } else {
        Provider.of<DatabaseHelper>(context, listen: false)
            .updateTask(widget.taskModel);
      }
      Navigator.pop(context);
    }
  }
}
