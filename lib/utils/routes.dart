import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/home_screen.dart';
import 'package:todo_app/ui/screens/splash_screen.dart';
import 'package:todo_app/ui/screens/summary_screen.dart';
import 'package:todo_app/ui/screens/task_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String home = '/home';

  static const String summary = '/summary';
  static const String taskScreen = '/taskScreen';

  static final initRoutes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    home: (BuildContext context) => HomeScreen(),
  };

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    if (settings.name == summary)
      return MaterialPageRoute(builder: (_) => SummaryScreen());
    if (settings.name == taskScreen) {
      final args = settings.arguments;
      return MaterialPageRoute(
        builder: (_) => TaskScreen(type: args),
      );
    }

    return MaterialPageRoute(builder: (_) => SummaryScreen());
  }
}
