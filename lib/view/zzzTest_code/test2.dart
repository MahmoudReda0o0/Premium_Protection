import 'package:flutter/material.dart';

import '../../model/local_data/local_task_data.dart';

class Test2 extends StatefulWidget {
  const Test2({super.key});

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  //List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  bool isDropDown = false;
  String selected = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Selected:$selected '),
        PopupMenuButton(
          onSelected: (value) {
            setState(() {
              selected = value;
            });
            print('💕💕💕$value');
          },
          onOpened: () {
            print('😁😁😁😁😁');
          },
          itemBuilder: (context) => List.generate(
            LocalTask.fixedTaskTypeList.length,
            (index) => PopupMenuItem(
              value: LocalTask.fixedTaskTypeList[index],
              child: Text(
                LocalTask.fixedTaskTypeList[index],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
