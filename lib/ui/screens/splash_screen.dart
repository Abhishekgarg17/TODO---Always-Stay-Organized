import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/ui/styles/colors.dart';
import 'package:todo_app/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
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
}
