import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view model/cubit/general_cubit/tasko_cubit.dart';

class Test2 extends StatelessWidget {
  const Test2({super.key});

  @override
  Widget build(BuildContext context) {
    BuildContext cubitContext =
        ModalRoute.of(context)?.settings.arguments as BuildContext;
    return Scaffold(
      body: BlocProvider.value(
        value: BlocProvider.of<TaskoCubit>(cubitContext),
        child: BlocBuilder<TaskoCubit, TaskoState>(
          builder: (context, state) {
            if (state is SuccessState) {
              return Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Success!'),
                ),
              );
            } else {
              //TODO :
              return Center(
                child: Column(
                  children: [
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('State: $state'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
