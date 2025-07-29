import 'package:simple/enum/count_change_type.dart';

abstract class HomeEvent {}

class InitEvent extends HomeEvent {}

class OnIncrementEvent extends HomeEvent {
  final int num;
  final CountChangeType type;

  OnIncrementEvent({required this.num, required this.type});
}
