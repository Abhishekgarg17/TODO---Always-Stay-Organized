import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/CustomBottomNavigatorBar.dart';
import 'package:todo_app/utils/globals.dart';
import 'package:todo_app/utils/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: bottomNavigator,
          onGenerateRoute: Routes.generateRoutes,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
