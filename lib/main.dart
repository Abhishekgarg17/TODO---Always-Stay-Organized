import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/splash_screen.dart';
import 'package:todo_app/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO-Stay Organized',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: Routes.initRoutes,
    );
  }
}
