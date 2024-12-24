import 'package:excp_training/view%20model/cubit/tasko_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Test1 extends StatelessWidget {
  Test1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              BlocProvider.of<TaskoCubit>(context).testCubit();
            },
            child: const Text('Test 1 Page')),
      ),
    );
  }
}
