// import 'dart:math';

// import 'package:excp_training/view/zzzTest_code/utils_test/app_route_test.dart';
// import 'package:excp_training/view/zzzTest_code/utils_test/argument_test.dart';
// import 'package:flutter/material.dart';

// class HomeTest extends StatelessWidget {
//   const HomeTest({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Student> students = List.generate(
//         50,
//         (index) => Student(
//             name: 'Student no ${index + 1}', age: Random().nextInt(50)));
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: students.length,
//         itemBuilder: (context, index) => ListTile(
//           leading: Text('${students[index].name}'),
//           trailing: Text('${students[index].age}'),
//           onTap: () {
//             Navigator.pushNamedAndRemoveUntil(
//               context,
//               AppRouteTest.test1,
//               arguments: students[index],
//               (route) => false,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
