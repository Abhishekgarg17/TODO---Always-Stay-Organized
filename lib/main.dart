import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/screens/splash_screen.dart';
import 'package:todo_app/utils/database_helper.dart';
import 'package:todo_app/utils/routes.dart';
import 'package:todo_app/utils/sqlite_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SqliteManager()),
        ChangeNotifierProxyProvider<SqliteManager, DatabaseHelper>(
          create: (context) => DatabaseHelper(
            null,
            null,
            null,
            null,
            null,
          ),
          update: (context, db, previous) => DatabaseHelper(
            previous.dueTodayList,
            previous.delayedList,
            previous.upcomingList,
            previous.doneList,
            db,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TODO-Stay Organized',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: Routes.initRoutes,
      ),
    );
  }
}
