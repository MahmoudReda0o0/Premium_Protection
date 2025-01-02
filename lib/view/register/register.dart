import 'package:excp_training/utils/route/app_route.dart';
import 'package:excp_training/view/login/login.dart';
import 'package:excp_training/view/widget/container_image.dart';
import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../utils/app_color.dart';
import '../../view model/cubit/tasko_cubit.dart';
import '../home_page/home_page.dart';
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
  late TextEditingController conEmail;
  late TextEditingController conPassword;
  late TextEditingController conConfirmPassword;
  late TextEditingController conFirstName;
  late TextEditingController conSecondName;
  late TextEditingController conLastName;
  late TextEditingController conCountry;
  late TextEditingController conPhoneNumber;

  @override
  void initState() {
    super.initState();
    conEmail = TextEditingController();
    conPassword = TextEditingController();
    conConfirmPassword = TextEditingController();
    conFirstName = TextEditingController();
    conSecondName = TextEditingController();
    conLastName = TextEditingController();
    conCountry = TextEditingController();
    conPhoneNumber = TextEditingController();
  }

  @override
  void dispose() {
    conEmail.dispose();
    conPassword.dispose();
    conConfirmPassword.dispose();
    conFirstName.dispose();
    conSecondName.dispose();
    conLastName.dispose();
    conCountry.dispose();
    conPhoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool activeKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: AppColor.white,
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
                  color: AppColor.grayDark,
                  fontStyle: FontStyle.italic),
            ),
            const Gap(10),
            Form(
              key: _formKey,
              child: Column(children: [
                TextFormCustom(
                  controller: conFirstName,
                  lableText: 'first Name',
                  errorMessage: 'please enter your first name',
                  onSaved: (value) => firstName = value!,
                ),
                TextFormCustom(
                  controller: conSecondName,
                  lableText: 'Second Name',
                  errorMessage: 'please enter your second name',
                  onSaved: (value) => secondName = value!,
                ),
                TextFormCustom(
                  controller: conLastName,
                  lableText: 'last Name',
                  errorMessage: 'please enter your last name',
                  onSaved: (value) => lastName = value!,
                ),
                TextFormCustom(
                    controller: conPhoneNumber,
                    lableText: 'Phone Number',
                    errorMessage: 'please enter your phone number',
                    onSaved: (value) => phoneNumber = value!),
                TextFormCustom(
                    controller: conCountry,
                    lableText: 'Country',
                    errorMessage: 'please enter your Counter',
                    onSaved: (value) => country = value!),
                TextFormCustom(
                    controller: conEmail,
                    lableText: 'Email',
                    errorMessage: 'please enter your email',
                    onSaved: (value) => email = value!),
                TextFormPasswordCustom(
                    controller: conPassword,
                    lableText: 'Password',
                    errorMessage: 'please enter your password',
                    onSaved: (value) => password = value!),
                TextFormPasswordCustom(
                    controller: conConfirmPassword,
                    lableText: 'Confirm Password',
                    errorMessage: 'please enter your password',
                    onSaved: (value) => confirmPassword = value!),
                FormSubmitButtonCustom.build(
                  onTap: () {
                    print('😅😍😒👍❤️👌😘😂😊💕😁🤣');
                    Navigator.pushNamed(context, AppRoute.homePage);
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
                Navigator.pushReplacementNamed(context, AppRoute.login);
              },
            ),
            activeKeyBoard
                ? Container(height: 150, width: 200, color: AppColor.white)
                : const Gap(50),
          ],
        ),
      ),
    );
  }
}
