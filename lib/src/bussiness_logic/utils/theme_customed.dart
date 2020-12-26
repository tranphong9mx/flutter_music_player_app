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
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none)));
