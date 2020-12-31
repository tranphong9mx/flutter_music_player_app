import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/models/song_info.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/utils/constants.dart';

class ThemeCustomed {
  final themeCustomed = ThemeData(
    fontFamily: 'ApercuPro',
    primaryColor: primaryLightBackgroundColor,
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
            letterSpacing: 1.2,
            color: primaryLightBackgroundColor,
            fontSize: 12)),
  );

  getThemeMap() => {
        SeasonSong.WINTER: <String, Color>{
          'bgGradientColor': chillhopWinFalDarkColor,
          'icTopBarColor': chillhopWinFalExtraColor,
          'titleTopBarColor': primaryLightBackgroundColor,
          'btnTextColor': primaryLightTextColor.withOpacity(0.8),
          'waveActiveColor': chillhopWinFalExtraDarkColor,
          'bgLightPlayBtnColor': chillhopWinFalSubColor,
          'bgDarkPlayBtnColor': chillhopWinFalSubDarkColor
        },
        SeasonSong.SPRING: <String, Color>{
          'bgGradientColor': chillhopSprSumSubColor,
          'icTopBarColor': chillhopSprSumSubDarkColor,
          'titleTopBarColor': chillhopSprSumSubDarkColor,
          'btnTextColor': primaryLightTextColor.withOpacity(0.8),
          'waveActiveColor': chillhopSprSumSubDarkColor,
          'bgLightPlayBtnColor': chillhopSprSumSubLightColor,
          'bgDarkPlayBtnColor': chillhopSprSumSubDarkColor
        },
        SeasonSong.SUMMER: <String, Color>{
          'bgGradientColor': chillhopSprSumColor,
          'icTopBarColor': chillhopSprSumDarkColor,
          'titleTopBarColor': primaryLightTextColor,
          'btnTextColor': primaryLightTextColor.withOpacity(0.8),
          'waveActiveColor': chillhopSprSumDarkColor,
          'bgLightPlayBtnColor': chillhopSprSumExtraLightColor,
          'bgDarkPlayBtnColor': chillhopSprSumLightColor
        },
        SeasonSong.FALL: <String, Color>{
          'bgGradientColor': chillhopWinFalSubColor,
          'icTopBarColor': chillhopWinFalSubDarkColor,
          'titleTopBarColor': primaryLightTextColor,
          'btnTextColor': primaryLightTextColor.withOpacity(0.8),
          'waveActiveColor': chillhopWinFalSubDarkColor,
          'bgLightPlayBtnColor': chillhopSprSumExtraLightColor,
          'bgDarkPlayBtnColor': chillhopSprSumLightColor
        },
      };
}
