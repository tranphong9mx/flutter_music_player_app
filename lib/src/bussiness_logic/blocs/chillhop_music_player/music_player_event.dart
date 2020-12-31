import 'package:equatable/equatable.dart';

import '../chillhop_music_player_bloc.dart';

@immutable
abstract class MusicPlayerEvent extends Equatable {
  MusicPlayerEvent();
  @override
  List<Object> get props => [];
}

// InResumed, InPaused, InNextSong, InPreviousSong, InStopped
// InShuffled, InOneRepeated, InAllRepeated, InNextSkipped, InPreviousSkipped

// START
class MusicPlayerInStarted extends MusicPlayerEvent {}

// PAUSE & RESUME
class MusicPlayerInResumed extends MusicPlayerEvent {}

class MusicPlayerInPaused extends MusicPlayerEvent {}

// NEXT & PREVIOUS

class MusicPlayerInNextPrevSong extends MusicPlayerEvent {
  final bool nextSong;
  MusicPlayerInNextPrevSong({this.nextSong = true});
}

// SKIP
class MusicPlayerInNextPrevSkipped extends MusicPlayerEvent {
  final bool skipNext;
  MusicPlayerInNextPrevSkipped({this.skipNext = true});
}

// STOP & SHUFFLE
class MusicPlayerInStopped extends MusicPlayerEvent {}

class MusicPlayerInShuffled extends MusicPlayerEvent {}


