import 'package:excp_training/view/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/constant.dart';
import '../../view model/cubit/tasko_cubit.dart';
import '../register/register.dart';
import '../widget/SnackBarCustom.dart';
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
  late TextEditingController conEmail;
  late TextEditingController conPassword;
  bool checkBoxValue = false;
  String sharedCheckBoxKey = 'remember Me';
  String sharedEmileKey = 'email key';
  String sharedPasswordKey = 'password key';
  bool? sharedPrefValue;

  sharedSetDate(String key, dynamic data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (data is bool) {
      pref.setBool(key, data);
    } else {
      pref.setString(key, data);
    }
  }

  sharedNavigate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    sharedPrefValue = pref.getBool(sharedCheckBoxKey);
    setState(() {});
    if (sharedPrefValue != true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      print('shared navigate value is false');
    }
  }

  @override
  void initState() {
    super.initState();
    sharedNavigate();
    conEmail = TextEditingController();
    conPassword = TextEditingController();
  }

  @override
  void dispose() {
    conEmail.dispose();
    conPassword.dispose();
    super.dispose();
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
                    controller: conEmail,
                    lableText: 'Enter Email',
                    errorMessage: 'Please enter your Email',
                    //textFieldValue: email,
                    // onSaved: (value) => email = value!,
                  ),
                  const Gap(10),
                  TextFormPasswordCustom(
                    controller: conPassword,
                    lableText: 'Enter Password',
                    errorMessage: 'Please enter correct Password',
                    //textFieldValue: password,
                    // onSaved: (value) => password = value!,
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ListTile(
                      leading: const Text(
                        'Remember Me',
                        style: TextStyle(
                            color: Constant.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      trailing: Checkbox(
                          value: checkBoxValue,
                          onChanged: (value) {
                            setState(() {
                              checkBoxValue = value!;
                            });
                          }),
                    ),
                  ),
                  const Gap(20),
                  FormSubmitButtonCustom.build(
                    onValidate: () {
                      SnackBarCustom.showSnackBar(
                        message: 'checkBoxValue: $checkBoxValue',
                        context: context,
                      );
                      if (checkBoxValue == true) {
                        sharedSetDate(sharedCheckBoxKey, checkBoxValue);
                        sharedSetDate(sharedEmileKey, conEmail.text);
                        sharedSetDate(sharedPasswordKey, conPassword.text);
                      }

                      BlocProvider.of<TaskoCubit>(context).userLogin();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const HomePage(),
                      //   ),
                      // );
                    },
                    formKey: _formKey,
                    snakBarMessage:
                        'Email: ${conEmail.text}, Password: ${conPassword.text} ',
                    context: context,
                  ),
                ],
              ),
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
