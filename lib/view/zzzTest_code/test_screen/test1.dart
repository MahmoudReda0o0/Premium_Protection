import 'package:excp_training/model/hive/hive_constant.dart';
import 'package:excp_training/model/models/task_model.dart';
import 'package:excp_training/model/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../model/hive/adapter/user_info_adapter.dart';
import '../../../model/models/type_model.dart';
import 'test2.dart';

class Test1 extends StatefulWidget {
  const Test1({super.key});

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  TextEditingController conText = TextEditingController();
  var hiveobject = Hive.box(HiveConstant.boxlocalData);
  List<String> typeList = ['play game', 'play game2', 'play game3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test1'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              hiveobject.put(
                  HiveConstant.keyUserInfo,
                  UserModel(
                    fristName: 'fristName',
                    secondName: 'secondName',
                    lastName: 'lastName',
                    phoneNumber: 'phoneNumber',
                    country: 'country',
                    email: 'email',
                    password: 'password',
                  ));
              hiveobject.put(
                  HiveConstant.keyTypeList, TypeModel(addedList: typeList));
              hiveobject.put(
                HiveConstant.keyTaskList,
                [
                  TaskModel(
                      name: 'test1',
                      type: 'test1',
                      description: 'test1',
                      dateAndTime: 'test1',
                      isNew: true),
                  TaskModel(
                      name: 'test2',
                      type: 'test2',
                      description: 'test2',
                      dateAndTime: 'test2',
                      isNew: true),
                ],
              );
              // hiveobject.putAll(
              //   {
              //     HiveConstant.keyTaskList: [
              //       TaskModelID(
              //         id: '1',
              //         task: TaskModel(
              //           name: 'test1',
              //           type: 'test1',
              //           description: 'test1',
              //           dateAndTime: 'test1',
              //           isNew: true,
              //         ),
              //       ),
              //       TaskModelID(
              //           id: '2',
              //           task: TaskModel(
              //             name: 'test2',
              //             type: 'test2',
              //             description: 'test2',
              //             dateAndTime: 'test2',
              //             isNew: true,
              //           ))
              //     ],
              //     HiveConstant.keyTypeList: TypeModel(addedList: typeList)
              //   },
              // );
            },
            child: Text('put Data'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Test2(),
                  ));
            },
            child: Text('get Data'),
          ),
        ],
      ),
    );
  }
}
