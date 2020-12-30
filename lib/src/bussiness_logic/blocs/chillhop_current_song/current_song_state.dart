part of 'current_song_cubit.dart';

@immutable
abstract class CurrentSongState {
  final int counter;
  CurrentSongState({
    this.counter,
  });
}

class CurrentSongIncrease extends CurrentSongState {
  CurrentSongIncrease({int counter})
      : super(counter: counter);
}

class CurrentSongDecrease extends CurrentSongState {
    CurrentSongDecrease({int counter})
      : super(counter: counter);
}
