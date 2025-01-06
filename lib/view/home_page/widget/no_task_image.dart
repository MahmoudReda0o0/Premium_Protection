import 'package:excp_training/main.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../utils/app_color.dart';
import '../../widget/container_image.dart';

class NoTaskImage   {
  
 static Widget build() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(180),
        ContainerImageCustom(
          height: 300,
          width: MediaQuery.of(navigatorKey.currentState!.context).size.width,
          image: 'assets/working.gif',
          fit: BoxFit.fitHeight,
        ),
        const Text(
          'Do Task To Change Your Life',
          style: TextStyle(
              color: AppColor.orangeWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
