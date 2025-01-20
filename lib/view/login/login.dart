//import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/model/hive/hive_constant.dart';
import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view%20model/cubit/login_cubit/login_cubit.dart';
import 'package:excp_training/view/home_page/home_page.dart';
import 'package:excp_training/view/widget/LoadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/local_data/shared_preference.dart';
import '../../utils/app_color.dart';

import '../../utils/route/app_route.dart';
import '../../view model/cubit/register/register_cubit.dart';
import '../home_page/home_page.dart';
import '../register/register.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/container_image.dart';
import '../widget/error_page.dart';
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

  // bool? sharedPrefValue;
  // String? getSharedEmailValue;
  // String? getSharedPasswordValue;

  // sharedNavigate() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   sharedPrefValue = pref.getBool(SharedPreferenceCustom.sharedCheckBoxKey);
  //   setState(() {});
  //   if (sharedPrefValue == true) {
  //     getSharedEmailValue =
  //         pref.getString(SharedPreferenceCustom.sharedEmileKey);
  //     getSharedPasswordValue =
  //         pref.getString(SharedPreferenceCustom.sharedPasswordKey);
  //     BlocProvider.of<LoginCubit>(context).setEmailAndPassword(
  //         emailValue: getSharedEmailValue!,
  //         passwordValue: getSharedPasswordValue!);
  //     await BlocProvider.of<LoginCubit>(context).userLogin();
  //     var cubitState = BlocProvider.of<LoginCubit>(context).state;
  //     if (cubitState is LoginSuccess) {
  //       BlocProvider.of<TaskoCubit>(context).getFirestoreTasks();
  //       Navigator.pushNamed(context, AppRoute.homePage);
  //     } else {
  //       SnackBarCustom.build(message: 'state: $cubitState ', context: context);
  //     }
  //   } else {
  //     print('shared navigate value is false');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // sharedNavigate();
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
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginInitial) {
          return loginBuild(context, activeKeyBoard);
        } else if (state is LoginSuccess) {
          return const Scaffold(
            backgroundColor: AppColor.buttonColor,
          );
        } else if (state is LoginLoading) {
          return const LoadingPage();
        } else if (state is LoginError) {
          return ErrorPage(
            errorMessage: state.errorMessage,
            onTap: () {
              BlocProvider.of<LoginCubit>(context).resetLoginState();
            },
          );
        } else {
          return ErrorPage(errorMessage: state.toString());
        }
      },
    );
  }

  Scaffold loginBuild(BuildContext context, bool activeKeyBoard) {
    var hiveCheckLogin = Hive.box(HiveConstant.checkLoginBox);
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
                    'Vesrsion 0.0.9',
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
                          BlocProvider.of<LoginCubit>(context)
                              .setEmailAndPassword(
                            emailValue: conEmail.text,
                            passwordValue: conPassword.text,
                          );
                          await BlocProvider.of<LoginCubit>(context)
                              .userLogin();
                          var cubitState =
                              BlocProvider.of<LoginCubit>(context).state;
                          if (cubitState is LoginSuccess) {
                            if (checkBoxValue == true) {
                              hiveCheckLogin.putAll({
                                HiveConstant.checkBoxKey: true,
                                HiveConstant.emailKey: conEmail.text,
                                HiveConstant.passwordKey: conPassword.text
                              });
                              // SharedPreferenceCustom.setSharedSetDate(
                              //     SharedPreferenceCustom.sharedCheckBoxKey,
                              //     checkBoxValue);
                              // SharedPreferenceCustom.setSharedSetDate(
                              //     SharedPreferenceCustom.sharedEmileKey,
                              //     conEmail.text);
                              // SharedPreferenceCustom.setSharedSetDate(
                              //     SharedPreferenceCustom.sharedPasswordKey,
                              //     conPassword.text);
                            }
                            BlocProvider.of<TaskoCubit>(context)
                                .getFirestoreTasks();
                            Navigator.pushReplacementNamed(
                                context, AppRoute.homePage);
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
                    Navigator.pushNamed(context, AppRoute.forgetPassword);
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
                      BlocProvider.of<RegisterCubit>(context)
                          .resetRegisterState();
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
