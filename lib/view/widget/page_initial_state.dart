import 'package:excp_training/utils/route/app_route.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class PageInitial extends StatelessWidget {
  const PageInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: mediaWidth * 0.9, child:const Text('Login again')),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.initialRoute);
              },
              label:const Text('Reload'),
              icon:const Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
