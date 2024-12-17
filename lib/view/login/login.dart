import 'package:excp_training/view/home_page/home_page.dart';
import 'package:excp_training/view/widget/SnackBarCustom.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../widget/container_image.dart';
import '../widget/text_form_custom.dart';
import '../widget/text_form_password_custom.dart';
import 'widget/rich_text_custom.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      email = '';
      password = '';
    });
    
    
  }

  @override
  Widget build(BuildContext context) {
    final activeKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constant.whiteColor,
      body: GestureDetector(
        onTap: () {
          print('tap on screen');
          FocusScope.of(context).requestFocus(new FocusNode()); //remove focus
          // WidgetsBinding.instance.addPostFrameCallback(
          //     (_) => _textEditingController.clear()); // clear content
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            if (!activeKeyBoard)
              ContainerImageCustom(
                image: Constant.logo_tile,
                height: 250,
                width: 250,
              ),
            const SizedBox(height: 35),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormCustom(
                    lableText: 'Enter Email',
                    errorMessage: 'Please enter your Email',
                    textFieldValue: email,
                    onSaved: (value) => email = value!,
                  ),
                  const SizedBox(height: 20),
                  TextFormPasswordCustom(
                    lableText: 'Enter Password',
                    errorMessage: 'Please enter correct Password',
                    textFieldValue: password,
                    onSaved: (value) => password = value!,
                  ),
                  const SizedBox(height: 30),
                  loginButton(context),
                  const SizedBox(height: 50),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Constant.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichTextCustom(
                    action: () {
                      SnackBarCustom.showSnackBar(
                          message: 'Rich Text Clicked',
                          context: context,
                          duration: 1);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    setState(() {
      email = '';
      password = '';
    });
    super.dispose();
  }

  SizedBox loginButton(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            SnackBarCustom.showSnackBar(
                message: 'Email: $email, Password: $password',
                context: context);

            // Process the form data
          }
        },
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.red))),
          backgroundColor:
              WidgetStateProperty.all<Color>(Constant.orangeGradientLight),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
            color: Constant.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
