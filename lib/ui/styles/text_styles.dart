import 'package:flutter/material.dart';

TextStyle headingTextStyle() {
  return new TextStyle(
    fontSize: 37,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 127, 127, 127),
  );
}

TextStyle appBarTextStyle() {
  return new TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

///Card Heading Text Style
TextStyle cardHeadingTextStyle() {
  return new TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 127, 127, 127),
  );
}

///Card SubHeading 1 Text Style
TextStyle cardSubHeading1TextStyle() {
  return new TextStyle(
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 127, 127, 127),
  );
}

///Card SubHeading 2 Text Style
TextStyle cardSubHeading2TextStyle() {
  return new TextStyle(
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 127, 127, 127),
  );
}

///Alert Card SubHeading 3 Text Style
TextStyle cardSubHeading3TextStyle() {
  return new TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.red,
  );
}

///Alert Card SubHeading 4 Text Style
TextStyle cardSubHeading4TextStyle() {
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
