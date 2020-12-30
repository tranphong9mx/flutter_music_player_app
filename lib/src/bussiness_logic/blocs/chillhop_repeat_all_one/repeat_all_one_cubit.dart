import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'repeat_all_one_state.dart';

class RepeatAllOneCubit extends Cubit<RepeatAllOneState> {
  RepeatAllOneCubit() : super(RepeatAll());
  repeatAll() => emit(RepeatAll());
  repeatOne() => emit(RepeatOne());
}
