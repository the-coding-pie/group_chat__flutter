import 'package:flutter/material.dart';

Color kRed = Color(0xFFFF0800);
Color kLightPink = Color(0xFFFFB6C1);

double kBoxHeight = 15.0;

InputDecoration kTextFieldDecoration = InputDecoration(
    hintText: "Enter text",
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0))));
