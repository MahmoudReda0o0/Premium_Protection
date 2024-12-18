import 'package:flutter/material.dart';

import '../widget/SnackBarCustom.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        SnackBarCustom.showSnackBar(message: 'hello', context: context);
      }),
      body: Container(),
    );
  }
}
