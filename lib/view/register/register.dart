import 'package:excp_training/view/login/login.dart';
import 'package:excp_training/view/widget/container_image.dart';
import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constant/constant.dart';
import '../home_page/home_page.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/form_submit_button.dart';
import '../widget/rich_text_custom.dart';
import '../widget/text_form_password_custom.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String email = '',
      password = '',
      confirmPassword = '',
      firstName = '',
      secondName = '',
      lastName = '',
      country = '',
      phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    bool _activeKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Constant.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(30),
            ContainerImageCustom(
              image: 'assets/logo_title.png',
              height: 120,
              width: 120,
            ),
            const Gap(20),
            const Text(
              'Welcome to our App ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Constant.accentTextColor,
                  fontStyle: FontStyle.italic),
            ),
            const Gap(10),
            Form(
              key: _formKey,
              child: Column(children: [
                TextFormCustom(
                  lableText: 'first Name',
                  errorMessage: 'please enter your first name',
                  onSaved: (value) => firstName = value!,
                ),
                TextFormCustom(
                  lableText: 'Second Name',
                  errorMessage: 'please enter your second name',
                  onSaved: (value) => secondName = value!,
                ),
                TextFormCustom(
                  lableText: 'last Name',
                  errorMessage: 'please enter your last name',
                  onSaved: (value) => lastName = value!,
                ),
                TextFormCustom(
                    lableText: 'Phone Number',
                    errorMessage: 'please enter your phone number',
                    onSaved: (value) => phoneNumber = value!),
                TextFormCustom(
                    lableText: 'Country',
                    errorMessage: 'please enter your Counter',
                    onSaved: (value) => country = value!),
                TextFormCustom(
                    lableText: 'Email',
                    errorMessage: 'please enter your email',
                    onSaved: (value) => email = value!),
                TextFormPasswordCustom(
                    lableText: 'Password',
                    errorMessage: 'please enter your password',
                    onSaved: (value) => password = value!),
                TextFormPasswordCustom(
                    lableText: 'Confirm Password',
                    errorMessage: 'please enter your password',
                    onSaved: (value) => confirmPassword = value!),
                FormSubmitButtonCustom.show(
                  onTap: () {
                    print('😅😍😒👍❤️👌😘😂😊💕😁🤣');
                    Navigator.push(context, MaterialPageRoute(builder: (builder) => const HomePage()));
                  },
                  formKey: _formKey,
                  snakBarMessage:
                      '''Email: $email, Password: $password , Confirm Password: $confirmPassword,
                       First Name: $firstName, Second Name: $secondName, Last Name: $lastName,
                        Country: $country, Phone Number: $phoneNumber''',
                  context: context,
                ),
              ]),
            ),
            const Gap(20),
            RichTextCustom(
              fristText: ' have an account ?',
              secondText: '  Login',
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
            _activeKeyBoard
                ? Container(
                    height: 150,
                    width: 200,
                    color: Constant.orangeGradientLight)
                : const Gap(50),
          ],
        ),
      ),
    );
  }
}
