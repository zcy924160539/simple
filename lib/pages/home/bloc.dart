import 'package:bloc/bloc.dart';
import 'package:simple/enum/count_change_type.dart';

import 'event.dart';
import 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState().init()) {
    on<InitEvent>(_init);
    on<OnIncrementEvent>(_incrementEvent);
  }

  void _init(InitEvent event, Emitter<HomeState> emit) async {
    emit(state.clone());
  }

  void _incrementEvent(OnIncrementEvent event, Emitter<HomeState> emit) {
    final int result;
    if (event.type == CountChangeType.increment) {
      result = state.count + event.num;
    } else {
      result = state.count - event.num;
    }
    emit(state.clone()..count = result);
  }
}
