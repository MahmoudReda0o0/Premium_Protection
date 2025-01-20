// import 'package:excp_training/model/firebase/auth.dart';
// import 'package:flutter/material.dart';

// class SignUpScreenTEST extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   SignUpScreenTEST({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Sign Up")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: "Email"),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: "Password"),
//               // obscureText: true,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 FirebaseAuthModel.setEmailAndPassword(
//                     emailValue: emailController.text,
//                     passwordValue: passwordController.text);
//                 await FirebaseAuthModel.singInWithEmailAndPassWord();
//               },
//               child: Text("Sign Up"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
