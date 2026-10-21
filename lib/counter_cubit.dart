import 'package:bn5_swd8_s1_apis/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(InitialCounterState());

  int counter = 0;

  void add() {
    counter++;
    emit(AddCounterState());
  }

  void sub() {
    counter--;
    emit(SubCounterState());
  }
}
