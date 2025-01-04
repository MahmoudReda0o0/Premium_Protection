import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/app_color.dart';

class ShowDateListTile extends StatelessWidget {
  ShowDateListTile({
    super.key,
    required this.listTileTitle,
    required this.text,
    this.trailing,
  });

  final String listTileTitle;
  final String text;
  Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.buttonColor, width: 2),
      ),
      child: ListTile(
        title: Text(
          text,
          style: const TextStyle(
            color: AppColor.grayDark,
            fontSize: 20,
            //fontWeight: FontWeight.bold,
          ),
        ),
        leading: Text(
          '$listTileTitle : ',
          style: const TextStyle(
            color: AppColor.grayDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: trailing??const SizedBox.shrink(),
      ),
    );
  }
}
