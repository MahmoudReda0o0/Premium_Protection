import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/constants.dart';

class TextIscompleted extends StatelessWidget {
   TextIscompleted({super.key, required this.isCompleted});
   bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: mediaWidth * 0.5,
      decoration: BoxDecoration(
        color: AppColor.grayWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isCompleted
                    ? AppColor.orangeWhite
                    : AppColor.green,
                width: 2),
          ),
          child: Text(
            isCompleted ? 'Not Completed' : 'Completed ',
            style: TextStyle(
              color: isCompleted
                  ? AppColor.orangeWhite
                  : AppColor.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

