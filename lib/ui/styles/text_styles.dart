import 'package:flutter/material.dart';

///Card Heading Text Style
TextStyle cardTextStyle() {
  return new TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

///Card SubHeading 1 Text Style
TextStyle cardSubHeadingTextStyle() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}

///Alert Card SubHeading 3 Text Style
TextStyle delayedDateTextStyle() {
  return new TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.red,
  );
}

///Alert Card SubHeading 4 Text Style
TextStyle upcomingDateTextStyle() {
  return new TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.green[700],
  );
}

///Input Decoration for Forms
InputDecoration formInputDecoration(labelText, prefixIcon, {errorText}) {
  return new InputDecoration(
    labelText: labelText,
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.all(0),
    prefixIcon: Icon(
      prefixIcon,
      color: Color.fromARGB(255, 180, 180, 180),
    ),
    labelStyle: new TextStyle(
      fontSize: 17,
      color: Color.fromARGB(255, 180, 180, 180),
    ),
    border: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 180, 180, 180)),
        borderRadius: BorderRadius.all(Radius.circular(6))),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange),
        borderRadius: BorderRadius.all(Radius.circular(6))),
  );
}
