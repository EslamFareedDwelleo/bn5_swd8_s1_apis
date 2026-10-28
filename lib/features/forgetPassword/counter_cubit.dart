import 'package:flutter_bloc/flutter_bloc.dart';

class CounterState {}

class ZeroCounterState extends CounterState {}

class IncreaseCounterState extends CounterState {}

class DecreaseCounterState extends CounterState {}

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(ZeroCounterState());

  int counter = 0;

  void increase() {
    counter++;
    emit(IncreaseCounterState());
    // emit(state + 1);
  }

  void decrease() {
    counter--;
    emit(DecreaseCounterState());
    // emit(state - 1);
  }

  void decreaseBy10() {
    counter--;
    emit(DecreaseCounterState());
    // emit(state - 1);
  }
}
