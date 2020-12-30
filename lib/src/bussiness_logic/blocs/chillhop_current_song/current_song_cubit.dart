import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_song_state.dart';

class CurrentSongCubit extends Cubit<CurrentSongState> {
  CurrentSongCubit() : super(CurrentSongIncrease(counter: 0));

  increase() => emit(CurrentSongIncrease(counter: state.counter + 1));
  noneChange() => emit(CurrentSongIncrease(counter: state.counter));
  decrease() => emit(CurrentSongDecrease(
      counter: state.counter > 0 ? state.counter - 1 : state.counter));

  @override
  Future<void> close() {
    return super.close();
  }
}
