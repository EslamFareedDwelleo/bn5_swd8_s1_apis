import 'package:bn5_swd8_s1_apis/counter_cubit.dart';
import 'package:bn5_swd8_s1_apis/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                // Call Action / Function From cubit
                context.read<CounterCubit>().add();
              },
              icon: Icon(Icons.add),
            ),

            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                print(state);
                int counter = context.read<CounterCubit>().counter;
                return Text(
                  counter.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    color: state is AddCounterState ? Colors.green : Colors.red,
                  ),
                );
              },
            ),

            IconButton(
              onPressed: () {
                context.read<CounterCubit>().sub();
              },
              icon: Icon(Icons.minimize),
            ),
          ],
        ),
      ),
    );
  }
}
