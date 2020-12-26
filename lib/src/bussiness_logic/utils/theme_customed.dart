import 'package:flutter/material.dart';

final themeCustomed = ThemeData(
    primaryColor: Colors.white,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
        hintStyle:
            TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Rubik'),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none)));
