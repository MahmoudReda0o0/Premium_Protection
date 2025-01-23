import 'package:excp_training/utils/route/app_route.dart';
import 'package:excp_training/view%20model/cubit/register/register_cubit.dart';
import 'package:excp_training/view/login/login.dart';
import 'package:excp_training/view/profile/profile.dart';
import 'package:excp_training/view/widget/container_image.dart';
import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../utils/app_color.dart';
import '../../view model/cubit/general_cubit/tasko_cubit.dart';
import '../../view model/cubit/profile/profile_cubit.dart';
import '../home_page/home_page.dart';
import '../widget/page_loading_state.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/page_error_state.dart';
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

  TextEditingController conFirstName = TextEditingController();
  TextEditingController conSecondName = TextEditingController();
  TextEditingController conLastName = TextEditingController();
  TextEditingController conCountry = TextEditingController();
  TextEditingController conPhoneNumber = TextEditingController();
  TextEditingController conEmail = TextEditingController();
  TextEditingController conPassword = TextEditingController();
  TextEditingController conConfirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    conFirstName.dispose();
    conSecondName.dispose();
    conLastName.dispose();
    conCountry.dispose();
    conPhoneNumber.dispose();
    conEmail.dispose();
    conPassword.dispose();
    conConfirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      if (state is RegisterInitial) {
        return _registerBuild(context);
      } else if (state is RegisterSuccess) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: Center(
            child: Text('state: ${state.toString()}'),
          ),
        );
      } else if (state is RegisterLoading) {
        return const PageLoading();
      } else if (state is RegisterError) {
        return PageError(
          errorMessage: state.errorMessage,
          onTap: () {
            BlocProvider.of<RegisterCubit>(context).resetRegisterState();
          },
        );
      }
      return PageError(errorMessage: state.toString());
    });
  }

  Scaffold _registerBuild(BuildContext context) {
    bool activeKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(0),
              ListTile(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.grayDark,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
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
                  ),
                  TextFormCustom(
                    controller: conSecondName,
                    lableText: 'Second Name',
                    errorMessage: 'please enter your second name',
                  ),
                  TextFormCustom(
                    controller: conLastName,
                    lableText: 'last Name',
                    errorMessage: 'please enter your last name',
                  ),
                  TextFormCustom(
                    controller: conPhoneNumber,
                    numberOnly: true,
                    lableText: 'Phone Number',
                    errorMessage: 'please enter your phone number',
                  ),
                  TextFormCustom(
                    controller: conCountry,
                    lableText: 'Country',
                    errorMessage: 'please enter your Counter',
                  ),
                  TextFormCustom(
                    controller: conEmail,
                    lableText: 'Email',
                    errorMessage: 'please enter your email',
                  ),
                  TextFormPasswordCustom(
                    controller: conPassword,
                    lableText: 'Password',
                    errorMessage: 'please enter your password',
                  ),
                  TextFormPasswordCustom(
                    controller: conConfirmPassword,
                    lableText: 'Confirm Password',
                    errorMessage: 'please enter your password',
                  ),
                  FormSubmitButtonCustom.build(
                    formKey: _formKey,
                    context: context,
                    onValidate: () async {
                      if (conPassword.text == conConfirmPassword.text) {
                        if (conEmail.text.contains('@') &&
                            conEmail.text.contains('.com')) {
                          await BlocProvider.of<RegisterCubit>(context)
                              .userRegister(
                                  fristName: conFirstName.text,
                                  secondName: conSecondName.text,
                                  lastName: conLastName.text,
                                  phoneNumber: conPhoneNumber.text,
                                  country: conCountry.text,
                                  email: conEmail.text,
                                  password: conPassword.text);
                          // await BlocProvider.of<ProfileCubit>(context)
                          //     .setUserInfo(
                          //   fristName: conFirstName.text,
                          //   secondName: conSecondName.text,
                          //   lastName: conLastName.text,
                          //   email: conEmail.text,
                          //   phoneNumber: conPhoneNumber.text,
                          //   country: conCountry.text,
                          // );

                          var registerCubitState =
                              BlocProvider.of<RegisterCubit>(context).state;
                          // var profileCubitState =
                          //     BlocProvider.of<RegisterCubit>(context).state;

                          if (registerCubitState is RegisterSuccess) {
                            Navigator.pushReplacementNamed(
                                context, AppRoute.login);
                          } else {
                            SnackBarCustom.build(
                              message:
                                  'Register Cubit state : ${registerCubitState.toString()}',
                              context: context,
                            );
                          }
                        } else {
                          SnackBarCustom.build(
                            message:
                                'Enter valid email , email must contain @gmail.com',
                            context: context,
                          );
                        }
                      } else {
                        SnackBarCustom.build(
                          message: 'Password does not match',
                          context: context,
                        );
                      }
                    },
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
      ),
    );
  }
}
