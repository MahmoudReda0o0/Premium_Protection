import 'package:excp_training/model/hive/adapter/user_info_adapter.dart';
import 'package:excp_training/model/hive/hive_fun.dart';
import 'package:excp_training/model/models/user_model.dart';
import 'package:excp_training/utils/constants.dart';
import 'package:excp_training/view%20model/cubit/internet_checker/internet_checker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../model/hive/hive_constant.dart';
import '../../../model/models/task_model.dart';
import '../../../model/models/type_model.dart';
import '../../../view model/cubit/general_cubit/tasko_cubit.dart';

class Test2 extends StatelessWidget {
  const Test2({super.key});

  @override
  Widget build(BuildContext context) {
    var hiveobject = Hive.box(HiveConstant.boxlocalData);
    late UserModel objUserOnfo = HiveFun.getUserInfo();
     List<TaskModel> objTaskList = HiveFun.getTaskModelList();
    List<String> objTypeList = HiveFun.getTypeInfo();
    return _offlineMode(objUserOnfo, objTaskList, objTypeList);
    // return BlocBuilder<InternetCheckerCubit, InternetCheckerState>(
    //   builder: (context, state) {
    //     if (state.isConnected) {
    //       return const Scaffold(
    //         body: Center(
    //           child: Text('Online Mode'),
    //         ),
    //       );
    //     } else {
    //       return _offlineMode(objUserOnfo, [], objTypeList);
    //     }
    //   },
    // );
  }

  Scaffold _offlineMode(UserModel objUserOnfo, List<TaskModel> objTaskList,
      List<String> objTypeList) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test1'),
      ),
      body: Column(
        children: [
          Text('${objUserOnfo.fristName}'),
          Text('${objUserOnfo.secondName}'),
          Text('${objUserOnfo.lastName}'),
          Text('${objUserOnfo.phoneNumber}'),
          Text('${objUserOnfo.country}'),
          Text('${objUserOnfo.email}'),
          Text('${objUserOnfo.password}'),
          Divider(),
          // Container(
          //   height: 300,
          //   width: mediaWidth,
          //   child: ListView.builder(
          //     itemCount: objTaskList.length,
          //     itemBuilder: (context, index) => ListTile(
          //       title: Text(objTaskList[index].name!),
          //       subtitle: Text(objTaskList[index].type!),
          //     ),
          //   ),
          // ),
          Divider(),
          Text('$objTypeList'),
        ],
      ),
    );
  }
}
