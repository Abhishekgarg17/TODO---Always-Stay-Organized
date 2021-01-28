import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/home_screen.dart';
import 'package:todo_app/ui/screens/splash_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String home = '/home';

  static final initRoutes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    home: (BuildContext context) => HomeScreen(),
  };
}
