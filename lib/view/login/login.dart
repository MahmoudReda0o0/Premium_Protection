import 'package:excp_training/view/home_page/home_page.dart';
import 'package:excp_training/view/widget/LoadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_color.dart';
import '../../view model/cubit/tasko_cubit.dart';
import '../../utils/route/app_route.dart';
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
    //sharedNavigate();
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
    return BlocBuilder<TaskoCubit, TaskoState>(
      builder: (context, state) {
        if (state is InitialState) {
          return loginBuild(context, activeKeyBoard);
        } else if (state is LoadingState) {
          return const Center(
            child: LoadingPage(),
          );
        } else {
          return Center(
            child: Text('Error State : $state'),
          );
        }
      },
    );
  }

  Scaffold loginBuild(BuildContext context, bool activeKeyBoard) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.white,
      body: GestureDetector(
        onTap: () {
          print('tap on screen');
          FocusScope.of(context).requestFocus(FocusNode()); //remove focus
          // WidgetsBinding.instance.addPostFrameCallback(
          //     (_) => _textEditingController.clear()); // clear content
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: const Text(
                    'Vesrsion 0.0.7',
                    style: TextStyle(
                        color: AppColor.grayDark, fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(5),
                Visibility(
                  visible: !activeKeyBoard,
                  child: ContainerImageCustom(
                    image: AppColor.logo_tile,
                    height: 230,
                    width: 230,
                  ),
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
                                color: AppColor.grayDark,
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
                        onValidate: () async {
                          // SnackBarCustom.build(
                          //   message: 'checkBoxValue: $checkBoxValue',
                          //   context: context,
                          // );
                          if (checkBoxValue == true) {
                            sharedSetDate(sharedCheckBoxKey, checkBoxValue);
                            sharedSetDate(sharedEmileKey, conEmail.text);
                            sharedSetDate(sharedPasswordKey, conPassword.text);
                          }
                          await BlocProvider.of<TaskoCubit>(context).userLogin(
                            email: conEmail.text,
                            password: conPassword.text,
                          );
                          var cubitState =
                              BlocProvider.of<TaskoCubit>(context).state;
                          if (cubitState is SuccessState) {
                            Navigator.pushNamed(context, AppRoute.homePage);
                          } else {
                            SnackBarCustom.build(
                                message: 'state: $cubitState ',
                                context: context);
                          }
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
                const Gap(30),
                TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const HomePage(),
                    //   ),
                    // );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColor.buttonColor,
                    ),
                  ),
                ),
                const Gap(20),
                RichTextCustom(
                    fristText: 'Don\'t have an account ?',
                    secondText: '  Register Now',
                    action: () {
                      Navigator.pushNamed(context, AppRoute.register);
                    }),
              ],
            ),
          ),
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
