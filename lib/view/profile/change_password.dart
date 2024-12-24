import 'package:excp_training/view%20model/cubit/tasko_cubit.dart';
import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:excp_training/view/widget/text_form_password_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../model/local_data/local_task_data.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/form_submit_button.dart';

// ignore: must_be_immutable
class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController conOldPassword = TextEditingController();
  TextEditingController conNewPassword = TextEditingController();
  TextEditingController conConfirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    conOldPassword.dispose();
    conNewPassword.dispose();
    conConfirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Task Detail '),
      ),
      body: Column(
        children: [
          const Gap(20),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormPasswordCustom(
                    lableText: 'Old Password',
                    errorMessage: 'Password incorrect',
                    controller: conOldPassword),
                TextFormPasswordCustom(
                    lableText: 'new Password',
                    errorMessage: 'Password must be more than 6 letters',
                    controller: conNewPassword),
                TextFormPasswordCustom(
                    lableText: 'Confirm Password',
                    errorMessage: 'Password must be more than 6 letters',
                    controller: conConfirmPassword),
                const Gap(20),
                FormSubmitButtonCustom.build(
                    context: context,
                    formKey: formKey,
                    onValidate: () {
                      BlocProvider.of<TaskoCubit>(context).submitEditPassword(
                          oldPassword: conOldPassword.text,
                          newPassword: conNewPassword.text,
                          confirmPassword: conConfirmPassword.text);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
