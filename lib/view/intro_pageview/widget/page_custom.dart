import 'package:excp_training/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widget/container_image.dart';

class PageCustom extends StatelessWidget {
   PageCustom({super.key, required this.imageURL, required this.text});
  String imageURL;
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContainerImageCustom(
          image: imageURL,
        ),
        const Gap(30),
         Text(
          text,
          style:const TextStyle(
              color: AppColor.grayDark,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
