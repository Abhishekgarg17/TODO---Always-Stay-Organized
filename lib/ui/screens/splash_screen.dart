import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/ui/styles/colors.dart';
import 'package:todo_app/utils/globals.dart';
import 'package:todo_app/utils/routes.dart';
import 'package:todo_app/utils/shared_pref_manager.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferenceManager _sharedPreferenceManager =
      new SharedPreferenceManager();

  @override
  void initState() {
    super.initState();
    getDataFromSf();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                height: height * 0.3,
                width: height * 0.3,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 15),
                child: Text(
                  "TODO",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 60,
                    color: mainTextColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                "Always stay organized",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 30,
                  color: mainTextColor,
                  letterSpacing: 1.5,
                  fontFamily: "Lobster",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  void navigate() {
    Navigator.popAndPushNamed(context, Routes.home);
  }

  void getDataFromSf() async {
    //Initialize all global lists and its count
    dueTodayList =
        await _sharedPreferenceManager.getFromSF(TaskType.DUE_TODAY) ??
            new List<TaskModel>();

    delayedList = await _sharedPreferenceManager.getFromSF(TaskType.DELAYED) ??
        new List<TaskModel>();
    upcomingList =
        await _sharedPreferenceManager.getFromSF(TaskType.UPCOMING) ??
            new List<TaskModel>();
    doneList = await _sharedPreferenceManager.getFromSF(TaskType.DONE) ??
        new List<TaskModel>();

    checkStatusWrtToday();

    //Initialize done list and its count
    dueTodayListCount = dueTodayList?.length ?? 0;
    delayedListCount = delayedList?.length ?? 0;
    upcomingListCount = upcomingList?.length ?? 0;
    doneListCount = doneList?.length ?? 0;
  }
}
