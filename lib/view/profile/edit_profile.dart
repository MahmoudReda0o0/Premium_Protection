import 'package:excp_training/model/local_data/local_user.dart';
import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view%20model/cubit/profile/profile_cubit.dart';
import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../model/firebase/FB_field_name.dart';
import '../../utils/app_color.dart';
import '../../model/local_data/local_task_data.dart';
import '../widget/LoadingPage.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/error_page.dart';
import '../widget/form_submit_button.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController conFristName;
  late TextEditingController conSecondName;
  late TextEditingController conLastName;
  late TextEditingController conEmail;
  late TextEditingController conphoneNum;
  late TextEditingController conCountry;

  @override
  void initState() {
    super.initState();
    // LocalUser? localUser = BlocProvider.of<ProfileCubit>(context).userDate;
    final cubitCurrentState = BlocProvider.of<ProfileCubit>(context).state;
    if (cubitCurrentState is ProfileSuccess) {
      conFristName = TextEditingController(
          text: cubitCurrentState.userInfo[FB.userFristName]);
      conSecondName = TextEditingController(
          text: cubitCurrentState.userInfo[FB.userSecondName]);
      conLastName = TextEditingController(
          text: cubitCurrentState.userInfo[FB.userLastName]);
      conEmail =
          TextEditingController(text: cubitCurrentState.userInfo[FB.userEmail]);
      conphoneNum = TextEditingController(
          text: cubitCurrentState.userInfo[FB.userPhoneNumber]);
      conCountry = TextEditingController(
          text: cubitCurrentState.userInfo[FB.userCountry]);
    } else {
      conFristName = TextEditingController(text: 'no data');
      conSecondName = TextEditingController(text: 'no data');
      conLastName = TextEditingController(text: 'no data');
      conEmail = TextEditingController(text: 'no data');
      conphoneNum = TextEditingController(text: 'no data');
      conCountry = TextEditingController(text: 'no data');
    }
  }

  @override
  void dispose() {
    conCountry.dispose();
    conEmail.dispose();
    conFristName.dispose();
    conLastName.dispose();
    conSecondName.dispose();
    conphoneNum.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      if (state is ProfileSuccess) {
        return _editProfileBuild(context);
      } else if (state is ProfileLoading) {
        return const LoadingPage();
      } else if (state is ProfileError) {
        return ErrorPage(
          errorMessage: state.errorMessage,
          onTap: () {
            Navigator.pop(context);
          },
        );
      } else if (state is ProfileUpdateSuccess) {
        return const Scaffold(
          backgroundColor: AppColor.white,
          body: Center(
            child: Text(
              'Your Profile Updated Successfully 🫡',
              style: TextStyle(
                  fontSize: 30,
                  color: AppColor.grayDark,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      return ErrorPage(
        errorMessage: state.toString(),
      );
    });
  }

  Scaffold _editProfileBuild(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(
                color: AppColor.grayDark,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormCustom(
                    controller: conFristName,
                    lableText: 'Frist Name',
                    errorMessage: "Enter Your Frist Name",
                  ),
                  TextFormCustom(
                      controller: conSecondName,
                      lableText: 'Second Name',
                      errorMessage: "Enter Your Second Name"),
                  TextFormCustom(
                      controller: conLastName,
                      lableText: 'Last Name',
                      errorMessage: "Enter Your Last Name"),
                  // TextFormCustom(
                  //     controller: conEmail,
                  //     lableText: 'Email',
                  //     errorMessage: "Enter Your Correct Email"),
                  TextFormCustom(
                      controller: conCountry,
                      lableText: 'Country',
                      errorMessage: "Enter Your Country"),
                  TextFormCustom(
                      controller: conphoneNum,
                      numberOnly: true,
                      lableText: 'Phone Num',
                      errorMessage: "Enter Your Phone Num"),
                  const Gap(20),
                  FormSubmitButtonCustom.build(
                      context: context,
                      formKey: _formKey,
                      onValidate: () async {
                        await BlocProvider.of<ProfileCubit>(context)
                            .updateUserinfo(
                          fristName: conFristName.text,
                          secondName: conSecondName.text,
                          lastName: conLastName.text,
                          phoneNumber: conphoneNum.text,
                          country: conCountry.text,
                          email: conEmail.text,
                        );
                        Navigator.pop(context);
                        // BlocProvider.of<TaskoCubit>(context)
                        //   ..submitEditProfile(
                        //     fristName: conFristName.text,
                        //     secondName: conSecondName.text,
                        //     lastName: conLastName.text,
                        //     phoneNumber: conphoneNum.text,
                        //     country: conCountry.text,
                        //     email: conEmail.text,
                        //   )
                        //   ..openProfile();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget taskIsDoneButton(
  //     {required bool taskBoolValue,
  //     required bool buttonBoolValue,
  //     // required String title,
  //     // required Color activeColor,
  //     // required Color secondColor,
  //     }) {
  //   return Expanded(
  //     child: ElevatedButton(
  //       style: ButtonStyle(
  //         shape: WidgetStateProperty.all<RoundedRectangleBorder>(
  //           RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15.0),
  //             //side: const BorderSide(color: Colors.red),
  //           ),
  //         ),
  //         backgroundColor:
  //             WidgetStateProperty.all<Color>(isNew ? activeColor : secondColor),
  //       ),
  //       onPressed: () {
  //         setState(() {
  //           isTaskNew = !isNew;
  //         });
  //       },
  //       child: Center(
  //         child: Text(title, style: const TextStyle(color: Colors.white),),
  //       ),
  //     ),
  //   );
  // }
}
