// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _rememberMe = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserPreferences();
//   }

//   Future<void> _loadUserPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _usernameController.text = prefs.getString('username') ?? '';
//       _passwordController.text = prefs.getString('password') ?? '';
//       _rememberMe = prefs.getBool('rememberMe') ?? false;
//     });
//   }

//   Future<void> _saveUserPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (_rememberMe) {
//       await prefs.setString('username', _usernameController.text);
//       await prefs.setString('password', _passwordController.text);
//       await prefs.setBool('rememberMe', true);
//     } else {
//       await prefs.remove('username');
//       await prefs.remove('password');
//       await prefs.setBool('rememberMe', false);
//     }
//   }

//   void _login() {
//     // Handle your login logic here
//     _saveUserPreferences();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Logged in successfully!')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             Row(
//               children: [
//                 Checkbox(
//                   value: _rememberMe,
//                   onChanged: (value) {
//                     setState(() {
//                       _rememberMe = value!;
//                     });
//                   },
//                 ),
//                 Text('Remember Me'),
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
