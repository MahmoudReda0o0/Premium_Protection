import 'package:excp_training/view/home_page/home_page.dart';
import 'package:excp_training/view/widget/SnackBarCustom.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constant/constant.dart';
import '../register/register.dart';
import '../widget/container_image.dart';
import '../widget/form_submit_button.dart';
import '../widget/text_form_custom.dart';
import '../widget/text_form_password_custom.dart';
import '../widget/rich_text_custom.dart';

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
    bool activeKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constant.whiteColor,
      body: GestureDetector(
        onTap: () {
          print('tap on screen');
          FocusScope.of(context).requestFocus(FocusNode()); //remove focus
          // WidgetsBinding.instance.addPostFrameCallback(
          //     (_) => _textEditingController.clear()); // clear content
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(80),
            if (!activeKeyBoard)
              ContainerImageCustom(
                image: Constant.logo_tile,
                height: 250,
                width: 250,
              ),
            const Gap(35),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormCustom(
                    lableText: 'Enter Email',
                    errorMessage: 'Please enter your Email',
                    //textFieldValue: email,
                    onSaved: (value) => email = value!,
                  ),
                  const Gap(10),
                  TextFormPasswordCustom(
                    lableText: 'Enter Password',
                    errorMessage: 'Please enter correct Password',
                    //textFieldValue: password,
                    onSaved: (value) => password = value!,
                  ),
                  const Gap(30),
                  FormSubmitButtonCustom.show(
                    onTap: () {
                      print('😅😍😒👍❤️👌😘😂😊💕😁🤣');
                       Navigator.push(context, MaterialPageRoute(builder: (builder) => const HomePage()));
                    },
                    formKey: _formKey,
                    snakBarMessage: 'Email: $email, Password: $password ',
                    context: context,
                  ),
                  const Gap(50),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Constant.primaryColor,
                      ),
                    ),
                  ),
                  const Gap(20),
                  RichTextCustom(
                      fristText: 'Don\'t have an account ?',
                      secondText: '  Register Now',
                      action: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  // @override
  // void dispose() {
  //   setState(() {
  //     email = '';
  //     password = '';
  //   });
  //   super.dispose();}
  // }
