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
        color: Constant.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Constant.buttonColor, width: 2),
      ),
      child: ListTile(
        title: Text(
          text,
          style: const TextStyle(
            color: Constant.grayDark,
            fontSize: 20,
            //fontWeight: FontWeight.bold,
          ),
        ),
        leading: Text(
          '$listTileTitle : ',
          style: const TextStyle(
            color: Constant.grayDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
