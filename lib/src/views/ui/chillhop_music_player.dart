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
import 'package:flutter_music_player_app/src/views/widgets/general_layout.dart';

class ChillHopMusicPlayer extends StatelessWidget {
  const ChillHopMusicPlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AudioPlayer _audioPlayer = AudioPlayer();
    AudioCache _audioCache = AudioCache(fixedPlayer: _audioPlayer);
    List<SongInfo> _playlist = ExampleData().getSongInfo();
    if (Platform.isIOS) {
      if (_audioCache.fixedPlayer != null) {
        _audioCache.fixedPlayer.startHeadlessService();
      }
    }
    return BlocProvider(
        create: (context) => MusicPlayerBloc(
            audioCache: _audioCache,
            audioPlayer: _audioPlayer,
            playlist: _playlist,
            currentSongCubit: CurrentSongCubit(),
            positionSongCubit: PositionSongCubit(),
            repeatAllOneCubit: RepeatAllOneCubit()),
        child: GeneralPlayout());
  }
}
