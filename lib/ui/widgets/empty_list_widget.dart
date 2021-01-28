import 'package:flutter/material.dart';
import 'package:todo_app/ui/styles/text_styles.dart';

class EmptyListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0),
      child: Column(
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
            style: cardTextStyle(),
          ),
        ],
      ),
    );
  }
}
