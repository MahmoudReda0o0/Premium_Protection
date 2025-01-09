import 'package:excp_training/utils/app_color.dart';
import 'package:excp_training/view/widget/form_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../model/firebase/auth.dart';
import '../../view model/cubit/forget_password/forget_password_cubit.dart';
import '../widget/LoadingPage.dart';
import '../widget/error_page.dart';
import '../widget/text_form_custom.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController conEmail = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

    @override
  void dispose() {
    conEmail.dispose();  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
      if (state is ForgetPasswordInitial) {
        return _forgetPassordBuild(context);
      } else if (state is ForgetPasswordSuccess) {
        return _forgetPassordBuild(context);
      } else if (state is ForgetPasswordLoading) {
        return const LoadingPage();
      } else if (state is ForgetPasswordError) {
        return ErrorPage(
          errorMessage: state.errorMessage,
          onTap: ()  {
            BlocProvider.of<ForgetPasswordCubit>(context).resetState();
            Navigator.pop(context);
          },
        );
      } else {
        return ErrorPage(errorMessage: state.toString());
      }
    });
  }

  Scaffold _forgetPassordBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(20),
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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Forgot Password',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColor.grayDark,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Gap(130),
                TextFormCustom(
                  controller: conEmail,
                  lableText: 'Email',
                  errorMessage: "Enter Your Email Address",
                ),
                // TextButton(
                //     onPressed: ()async {
                //      await  FirebaseAuthModel.emailVerification();
                //     },
                //     child: Text('email verification')),
                const Gap(20),
                FormSubmitButtonCustom.build(
                    formKey: _formkey,
                    context: context,
                    onValidate: () {
                      BlocProvider.of<ForgetPasswordCubit>(context)
                          .resetPassword(conEmail.text);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
