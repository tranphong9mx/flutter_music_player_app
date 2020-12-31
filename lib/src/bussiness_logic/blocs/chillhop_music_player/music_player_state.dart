import 'package:equatable/equatable.dart';

abstract class MusicPlayerState extends Equatable {
  MusicPlayerState();
  @override
  List<Object> get props => [];
}

// InPlay, InComplete, InPause

class MusicPlayerInitial extends MusicPlayerState {}

class MusicPlayerPlaying extends MusicPlayerState {}

class MusicPlayerPausing extends MusicPlayerState {}

class MusicPlayerCompleting extends MusicPlayerState {}
