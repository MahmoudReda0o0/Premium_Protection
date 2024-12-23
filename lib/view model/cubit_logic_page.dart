import 'package:excp_training/view%20model/cubit/tasko_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/login/login.dart';

class CubitLogicPage extends StatelessWidget {
  const CubitLogicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskoCubit, TaskoState>(
        builder: (context, state) {
          if (state is TaskoInitial) {
            return const Login();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
