import 'package:excp_training/utils/app_color.dart';
import 'package:excp_training/utils/constants.dart';
import 'package:flutter/material.dart';

class PageLoading extends StatelessWidget {
  const PageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
