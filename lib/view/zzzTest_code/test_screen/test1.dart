import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../model/hive/hive_user.dart';
import '../../../utils/android_home_page/android_widget_manager.dart';


class Test1 extends StatefulWidget {
  const Test1({super.key});

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  TextEditingController conText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var hiveUser = Hive.box(HiveUser.boxID);
    // final Student student =
    //     ModalRoute.of(context)!.settings.arguments as Student;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test1'),
      ),
      body: Column(
        children: [
          Text(hiveUser.get('name') ?? ''),
          TextField(
            controller: conText,
          ),
          ElevatedButton(
              onPressed: () {
                hiveUser.put('name', conText.text);
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
