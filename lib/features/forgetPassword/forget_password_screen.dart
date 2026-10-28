import 'package:bn5_swd8_s1_apis/features/forgetPassword/check_box_cubit.dart';
import 'package:bn5_swd8_s1_apis/features/forgetPassword/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<CounterCubit>().increase();
                  },
                  icon: Icon(Icons.add),
                ),
                BlocBuilder<CounterCubit, CounterState>(
                  builder: (context, state) {
                    if (state is IncreaseCounterState) {
                      return Row(
                        children: [
                          Icon(Icons.arrow_upward),
                          Text("${context.read<CounterCubit>().counter}"),
                        ],
                      );
                    }

                    return Text("${context.read<CounterCubit>().counter}");
                  },
                ),
                IconButton(
                  onPressed: () {
                    context.read<CounterCubit>().decrease();
                  },
                  icon: Icon(Icons.minimize),
                ),
              ],
            ),
            BlocBuilder<CheckBoxCubit, bool>(
              builder: (context, state) {
                return Checkbox(
                  value: state,
                  onChanged: (value) {
                    context.read<CheckBoxCubit>().changeChecked();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
