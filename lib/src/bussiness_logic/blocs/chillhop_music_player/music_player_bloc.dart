import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/blocs/chillhop_current_song/current_song_cubit.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/blocs/chillhop_position_song/position_song_cubit.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/blocs/chillhop_repeat_all_one/repeat_all_one_cubit.dart';
import 'package:flutter_music_player_app/src/bussiness_logic/models/song_info.dart';

import '../chillhop_music_player_bloc.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final AudioPlayer audioPlayer;
  final AudioCache audioCache;
  final CurrentSongCubit currentSongCubit;
  final PositionSongCubit positionSongCubit;
  final RepeatAllOneCubit repeatAllOneCubit;
  static const int SKIP_MUSIC_SECONDS = 10;
  List<SongInfo> playlist;

  int _duration = 0;
  int _position = 0;
  int _currentSong = 0;
  StreamSubscription<PositionSongState> _streamSubPosition;
  StreamSubscription<CurrentSongState> _streamSubCurrentSong;

  MusicPlayerBloc({
    @required this.audioCache,
    @required this.audioPlayer,
    @required this.currentSongCubit,
    @required this.positionSongCubit,
    @required this.repeatAllOneCubit,
  }) : super(MusicPlayerInitial()) {
    // AUDIO PLAYER LISTENING
    audioPlayer.onPlayerStateChanged.listen((event) {
      switch (event) {
        case AudioPlayerState.PLAYING:
          audioPlayer.onAudioPositionChanged.listen((position) {
            positionSongCubit.increase(position.inSeconds);
          });
          break;
        case AudioPlayerState.COMPLETED:
          this.add(MusicPlayerInNextPrevSong(nextSong: true));
          break;
        default:
          break;
      }
    });

    _streamSubCurrentSong = currentSongCubit.listen((state) {
      _currentSong = state.counter;
    });

    _streamSubPosition = positionSongCubit.listen((state) {
      _position = state.position;
    });
  }

  // REMEMBER SET PLAYLIST BEFORE HANDLE ANYTHING TO AVOID ERRORS
  setPlaylist(List<SongInfo> playlist) => this.playlist = playlist;

  @override
  Future<void> close() {
    _streamSubPosition.cancel();
    _streamSubCurrentSong.cancel();
    audioCache.clearCache();
    return super.close();
  }

  @override
  Stream<MusicPlayerState> mapEventToState(
    MusicPlayerEvent event,
  ) async* {
    if (event is MusicPlayerInStarted) {
      yield* _mapStartedToState(event);
    } else if (event is MusicPlayerInPaused) {
      yield* _mapPausedToState(event);
    } else if (event is MusicPlayerInResumed) {
      yield* _mapResumedToState(event);
    } else if (event is MusicPlayerInNextPrevSong) {
      yield* _mapNextPrevToState(event);
    } else if (event is MusicPlayerInNextPrevSkipped) {
      yield* _mapNextPrevSkippedToState(event);
    } else if (event is MusicPlayerInShuffled) {
      yield* _mapShuffledToState(event);
    }
  }

  _getRepeatState(RepeatAllOneState state) => state is RepeatAll ? true : false;

  Stream<MusicPlayerState> _mapStartedToState(
      MusicPlayerInStarted event) async* {
    _playMusic();
    yield MusicPlayerPlaying();
  }

  Stream<MusicPlayerState> _mapNextPrevToState(
      MusicPlayerInNextPrevSong event) async* {
    _getRepeatState(repeatAllOneCubit.state)
        ? event.nextSong
            ? currentSongCubit.increase()
            : currentSongCubit.decrease()
        : currentSongCubit.noneChange();

    _stopMuic();
    yield MusicPlayerCompleting();
    await Future.delayed(Duration(milliseconds: 450));
    _playMusic();
    yield MusicPlayerPlaying();
  }

  Stream<MusicPlayerState> _mapNextPrevSkippedToState(
      MusicPlayerInNextPrevSkipped event) async* {
    _skipMusic(SKIP_MUSIC_SECONDS, event.skipNext);
  }

  Stream<MusicPlayerState> _mapPausedToState(MusicPlayerInPaused event) async* {
    _pauseMusic();
    yield MusicPlayerPausing();
  }

  Stream<MusicPlayerState> _mapResumedToState(
      MusicPlayerInResumed event) async* {
    _playMusic();
    yield MusicPlayerPlaying();
  }

  Stream<MusicPlayerState> _mapShuffledToState(
      MusicPlayerInShuffled event) async* {
    _shuffleMusic();
  }

  // MUSIC PLAYER FUNCTION
  _playMusic() =>
      audioCache.play(_getFilePathSong(_currentSong % playlist.length));
  _pauseMusic() => audioPlayer.pause();
  _stopMuic() => audioPlayer.stop();
  _shuffleMusic() => playlist.shuffle();

  _skipMusic(int seconds, bool skipNext) => skipNext
      ? audioPlayer.seek(Duration(
          seconds:
              _position <= (_duration - 10) ? _position + seconds : _duration))
      : audioPlayer.seek(
          Duration(seconds: _position >= seconds ? _position - seconds : 0));

  // GET INFO FUNCTION
  getNameSong(int current) => playlist[current % playlist.length].getName;

  getAuthorSong(int current) => playlist[current % playlist.length].getAuthor;

  getFormatTimer(int timer, {bool minus = false}) {
    String syntax =
        '${(timer / 60).floor().toString().padLeft(2, '0')}.${(timer % 60).toString().padLeft(2, '0')}';
    return minus ? '-' + syntax : syntax;
  }

  // SONG HANDLED FUNCTION
  Future<int> _getDuration(
      String fileUrl, AudioPlayer audioPlayer, AudioCache audioCache) async {
    File audio = await audioCache.load(fileUrl);
    audioPlayer.setUrl(audio.path);
    // Return duration as milliseconds
    return ((await Future.delayed(
                Duration(milliseconds: 300), () => audioPlayer.getDuration())) /
            1000)
        .floor();
  }

  getDuration() {
    _getDuration(_getFilePathSong(_currentSong % playlist.length), audioPlayer,
            audioCache)
        .then((value) => _duration = value);
    return _duration;
  }

  _getFilePathSong(int current) {
    String urlSong = 'audio/';
    switch (playlist[current].getType) {
      case SeasonSong.SPRING:
        urlSong += 'chillhop_spring/';
        break;
      case SeasonSong.SUMMER:
        urlSong += 'chillhop_summer/';
        break;
      case SeasonSong.FALL:
        urlSong += 'chillhop_fall/';
        break;
      default:
        urlSong += 'chillhop_winter/';
        break;
    }
    return urlSong += '${playlist[current].getName}.mp3';
  }
}
