import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'position_song_state.dart';

class PositionSongCubit extends Cubit<PositionSongState> {
  PositionSongCubit() : super(PositionSongState(position: 0));

  increase(int position) => emit(PositionSongState(position: position));
}
