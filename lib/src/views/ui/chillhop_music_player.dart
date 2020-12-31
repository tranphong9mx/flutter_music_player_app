import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/blocs/chillhop_current_song/current_song_cubit.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/blocs/chillhop_music_player_bloc.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/blocs/chillhop_position_song/position_song_cubit.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/blocs/chillhop_repeat_all_one/repeat_all_one_cubit.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/data/example_data.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/models/song_info.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/utils/constants.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/utils/theme_customed.dart';
import 'package:flutter_music_player_app/src/views/ui/chillhop_general_layout.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class ChillHopMusicPlayer extends StatelessWidget {
  ChillHopMusicPlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer _audioPlayer = AudioPlayer();
    Map<int, List<SongInfo>> _songMap = ExampleData().getSongMap();
    Map<SeasonSong, Map<String, Color>> _themeMap =
        ThemeCustomed().getThemeMap();
    AudioCache _audioCache = AudioCache(fixedPlayer: _audioPlayer);
    if (Platform.isIOS) {
      if (_audioCache.fixedPlayer != null) {
        _audioCache.fixedPlayer.startHeadlessService();
      }
    }
    List<Widget> _page = [
      ChillhopGeneralPlayout(
        seasonTheme: _themeMap[SeasonSong.WINTER],
        backgroundImage: 'assets/images/chillhop_winter.png',
        playlist: _songMap[0],
      ),
      ChillhopGeneralPlayout(
          seasonTheme: _themeMap[SeasonSong.SPRING],
          backgroundImage: 'assets/images/chillhop_spring.png',
          playlist: _songMap[1]),
      ChillhopGeneralPlayout(
          seasonTheme: _themeMap[SeasonSong.SUMMER],
          backgroundImage: 'assets/images/chillhop_summer.png',
          playlist: _songMap[2]),
      ChillhopGeneralPlayout(
          seasonTheme: _themeMap[SeasonSong.FALL],
          backgroundImage: 'assets/images/chillhop_fall.png',
          playlist: _songMap[3]),
    ];

    return BlocProvider(
        create: (context) => MusicPlayerBloc(
            audioCache: _audioCache,
            audioPlayer: _audioPlayer,
            currentSongCubit: CurrentSongCubit(),
            positionSongCubit: PositionSongCubit(),
            repeatAllOneCubit: RepeatAllOneCubit()),
        child: LiquidSwipe(
            pages: _page,
            enableLoop: true,
            fullTransitionValue: 300,
            enableSlideIcon: true,
            waveType: WaveType.liquidReveal,
            slideIconWidget: Icon(
              Icons.arrow_back_ios,
              color: primaryLightTextColor.withOpacity(0.8),
            ),
            positionSlideIcon: 0.3));
  }
}
