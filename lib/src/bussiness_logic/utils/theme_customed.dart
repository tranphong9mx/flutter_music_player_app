import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/utils/constants.dart';

final themeCustomed = ThemeData(
    fontFamily: 'ApercuPro',
    primaryColor: primarySprSumColor,
    backgroundColor: primaryLightBackgroundColor,
    scaffoldBackgroundColor: primaryLightBackgroundColor,
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: primaryLightTextColor, fontSize: 14),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none)),
    textTheme: TextTheme(
        headline6: TextStyle(
            color: primaryLightTextColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5),
        bodyText1: TextStyle(
            letterSpacing: 1.2,
            color: primaryLightTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w200),
        bodyText2: TextStyle(
            letterSpacing: 1.2, color: primaryLightTextColor, fontSize: 12)));
