import 'package:excp_training/constant/constant.dart';
import 'package:flutter/material.dart';

class ContainerImageCustom extends StatelessWidget {
  ContainerImageCustom(
      {super.key, this.height = 200, this.width = 200, required this.image});
  double height;
  double width;
  String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      //margin: margin,
      decoration: BoxDecoration(
        color: Constant.whiteColor,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
