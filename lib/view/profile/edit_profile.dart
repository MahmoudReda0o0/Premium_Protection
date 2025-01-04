import 'package:excp_training/model/local_data/local_user.dart';
import 'package:excp_training/view%20model/cubit/general_cubit/tasko_cubit.dart';
import 'package:excp_training/view%20model/cubit/profile/profile_cubit.dart';
import 'package:excp_training/view/widget/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../utils/app_color.dart';
import '../../model/local_data/local_task_data.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/form_submit_button.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController conFristName;
  late TextEditingController conSecondName;
  late TextEditingController conLastName;
  late TextEditingController conEmail;
  late TextEditingController conphoneNum;
  late TextEditingController conCountry;

  @override
  void initState() {
    super.initState();
    LocalUser localUser = BlocProvider.of<ProfileCubit>(context).localUser!;
    //final cubitCurrentState = BlocProvider.of<ProfileCubit>(context).state;
    //if (cubitCurrentState is ProfileSuccess) {
    conFristName = TextEditingController(text: localUser.fristName);
    conSecondName = TextEditingController(text: localUser.secondName);
    conLastName = TextEditingController(text: localUser.lastName);
    conEmail = TextEditingController(text: localUser.email);
    conphoneNum = TextEditingController(text: localUser.phoneNumber);
    conCountry = TextEditingController(text: localUser.country);
    // } else {
    //   conFristName = TextEditingController(text: 'no data');
    //   conSecondName = TextEditingController(text: 'no data');
    //   conLastName = TextEditingController(text: 'no data');
    //   conEmail = TextEditingController(text: 'no data');
    //   conphoneNum = TextEditingController(text: 'no data');
    //   conCountry = TextEditingController(text: 'no data');
    // }
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
              key: formKey,
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
                  TextFormCustom(
                      controller: conEmail,
                      lableText: 'Email',
                      errorMessage: "Enter Your Correct Email"),
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
                      formKey: formKey,
                      onValidate: () {
                        BlocProvider.of<ProfileCubit>(context).editProfile(
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
