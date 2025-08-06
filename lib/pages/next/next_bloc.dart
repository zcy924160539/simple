import 'package:bloc/bloc.dart';

import 'next_event.dart';
import 'next_state.dart';

class NextBloc extends Bloc<NextEvent, NextState> {
  NextBloc() : super(NextState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<NextState> emit) async {
    emit(state.clone());
  }
}
