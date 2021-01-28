import 'package:flutter/material.dart';

class TaskCountCard extends StatelessWidget {
  final Color color;
  final String type;
  final int count;

  const TaskCountCard({
    Key key,
    this.color,
    this.type,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
      height: MediaQuery.of(context).size.width * 0.24,
      child: Card(
        elevation: 10,
        color: color,
        shadowColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Text(
                count.toString(),
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              type,
              style: new TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
