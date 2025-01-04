import 'package:excp_training/utils/app_color.dart';
import 'package:flutter/material.dart';

class ContainerImageCustom extends StatelessWidget {
  ContainerImageCustom(
      {super.key,
      this.height = 200,
      this.width = 200,
      required this.image,
      this.fit = BoxFit.cover});
  double height;
  double width;
  String image;
  BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      //margin: margin,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: fit,
        ),
      ),
    );
  }
}
