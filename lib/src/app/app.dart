import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/utils/theme_customed.dart';
import 'package:flutter_music_player_app/src/views/ui/chillhop_music_player.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeCustomed().themeCustomed,
      home: ChillHopMusicPlayer(),
    );
  }
}
