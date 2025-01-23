import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/constants.dart';
import '../../widget/show_date_listTile.dart';

class OfflineType extends StatelessWidget {
  OfflineType({super.key, required this.addedType});
  List<String> addedType;

  List<String> fixedTypeList = [
    'Work',
    'Study',
    'Chores',
    'Fitness',
    'Shopping',
    'Travel',
    'Health',
    'Events',
    'Hobbies',
    'Finance',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Type',
          style: TextStyle(
            color: AppColor.grayDark,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: mediaHeight * 0.9,
        width: mediaWidth,
        color: AppColor.grayWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('fixed Task Type'),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 15),
                color: AppColor.grayWhite,
                child: ListView.builder(
                  itemCount: fixedTypeList.length,
                  itemBuilder: (context, index) {
                    return ShowDateListTile(
                      listTileTitle: '${index + 1} ',
                      text: fixedTypeList[index],
                    );
                  },
                ),
              ),
            ),
            const Divider(
              color: AppColor.grayDark,
            ),
            const Text('Added Task Type'),
            Expanded(
              child: Container(
                color: AppColor.grayWhite,
                child: addedType.isEmpty
                    ? const Center(
                        child: Text(
                        'No Added Task Type',
                      ))
                    : ListView.builder(
                        itemCount: addedType.length,
                        itemBuilder: (context, index) {
                          return ShowDateListTile(
                            listTileTitle: '${index + 1} ',
                            text:addedType[index],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


