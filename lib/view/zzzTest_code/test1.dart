import 'package:excp_training/utils/route/app_route.dart';
import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view/zzzTest_code/test2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'utils_test/argument_test.dart';

class Test1 extends StatelessWidget {
  const Test1({super.key});

  @override
  Widget build(BuildContext context) {
    // final Student student =
    //     ModalRoute.of(context)!.settings.arguments as Student;
    return Scaffold(
      body: Column(
        children: [
          //Text('${student.name}'),
          Center(
            child: TextButton(
              onPressed: () {
                //BlocProvider.of<TaskoCubit>(context).getTestData();
                Navigator.of(context)
                    .pushNamed(AppRoute.test2, arguments: context);
              },
              child: const Text('Name : Go to Test 2'),
            ),
          ),
        ],
      ),
    );
  }
}
