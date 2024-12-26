import 'package:flutter/material.dart';

import '../../constant/constant.dart';

class ShowDateListTile extends StatelessWidget {
  const ShowDateListTile({
    super.key,
    required this.listTileTitle,
    required this.text,
  });

  final String listTileTitle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Constant.whiteGray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          text,
          style: const TextStyle(
            color: Constant.blackColor,
            fontSize: 20,
            //fontWeight: FontWeight.bold,
          ),
        ),
        leading: Text(
          '$listTileTitle : ',
          style: const TextStyle(
            color: Constant.darkGray,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
