import 'package:excp_training/view/profile/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../constant/constant.dart';
import '../../view model/cubit/tasko_cubit.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/button_custom.dart';
import '../widget/show_date_listTile.dart';
import 'edit_profile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskoCubit, TaskoState>(builder: (context, state) {
        if (state is ProfileState) {
          return Column(
            children: [
              const Gap(20),
              Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                padding: const EdgeInsets.only(bottom: 5, top: 10),
                decoration: BoxDecoration(
                    color: Constant.darkGray,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShowDateListTile(
                      listTileTitle: 'Name ',
                      text:
                          '${state.localUser.fristName} ${state.localUser.secondName} ${state.localUser.lastName}',
                    ),
                    ShowDateListTile(
                        listTileTitle: 'Email ',
                        text: '${state.localUser.email}'),
                    ShowDateListTile(
                        listTileTitle: 'Phone num ',
                        text: '${state.localUser.phoneNumber}'),
                    ShowDateListTile(
                        listTileTitle: 'Country ',
                        text: '${state.localUser.country}'),
                    ShowDateListTile(
                        listTileTitle: 'password ',
                        text: '${state.localUser.password}'),
                  ],
                ),
              ),
              const Gap(30),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonCustom.build(
                          title: 'Edit Password ',
                          buttonColor: Constant.brightGreent,
                          textColor: Constant.whiteColor,
                          onPressed: () {
                            BlocProvider.of<TaskoCubit>(context)
                                .openEditPassword();
                          }),
                    ),
                    const Gap(20),
                    Expanded(
                      child: ButtonCustom.build(
                          title: 'Edit Profile',
                          buttonColor: Constant.orangeGradientLight,
                          textColor: Constant.whiteColor,
                          onPressed: () {
                            BlocProvider.of<TaskoCubit>(context)
                                .openEditProfile(localUser: state.localUser);
                          }),
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return Center(
            child: Text('error $state}'),
          );
        }
      }),
    );
  }
}
