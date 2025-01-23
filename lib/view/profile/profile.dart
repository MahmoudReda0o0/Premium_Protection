import 'package:excp_training/view%20model/cubit/Internet_checker/internet_checker_cubit.dart';
import 'package:excp_training/view%20model/cubit/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../model/hive/hive_fun.dart';
import '../../model/models/user_model.dart';
import '../../utils/app_color.dart';
import '../../utils/route/app_route.dart';
import '../widget/page_loading_state.dart';
import '../widget/button_custom.dart';
import '../widget/page_error_state.dart';
import '../widget/show_date_listTile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCheckerCubit, InternetCheckerState>(
      //connect: check internet
      builder: (context, internetState) {
        if (internetState.isConnected) {
          return BlocBuilder<ProfileCubit, ProfileState>(
            // User Profile
            builder: (context, profileState) {
              if (profileState is ProfileSuccess) {
                return _profileBuild(context, profileState.userInfo, true);
              } else if (profileState is ProfileLoading) {
                return const PageLoading();
              } else if (profileState is ProfileError) {
                return PageError(
                  errorMessage: profileState.errorMessage,
                  onTap: () {
                    Navigator.pop(context);
                  },
                );
              } else {
                return PageError(
                  errorMessage: profileState.toString(),
                );
              }
            },
          );
        } else {
          // Offline Mode
          UserModel objUserOnfo = HiveFun.getUserInfo();
          return _profileBuild(context, objUserOnfo, false);
        }
      },
    );
  }

  Scaffold _profileBuild(
      BuildContext context, UserModel userInfo, bool isConnected) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Gap(20),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            padding: const EdgeInsets.only(bottom: 5, top: 10),
            decoration: BoxDecoration(
                color: AppColor.grayWhite,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShowDateListTile(
                  listTileTitle: 'Name ',
                  text:
                      '${userInfo.fristName} ${userInfo.secondName} ${userInfo.lastName}',
                ),
                ShowDateListTile(
                    listTileTitle: 'Email ', text: userInfo.email!),
                ShowDateListTile(
                    listTileTitle: 'Phone num ', text: userInfo.phoneNumber!),
                ShowDateListTile(
                    listTileTitle: 'Country ', text: userInfo.country!),
                // ShowDateListTile(
                //     listTileTitle: 'password ', text: state.userInfo[FBCollectionName.userPassword]),
              ],
            ),
          ),
          const Gap(50),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: isConnected
                ? Row(
                    children: [
                      Expanded(
                        child: ButtonCustom.build(
                            title: 'Edit Password ',
                            tilteSize: 19,
                            buttonColor: AppColor.orangeWhite,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoute.editPassword);
                            }),
                      ),
                      const Gap(20),
                      Expanded(
                        child: ButtonCustom.build(
                            title: 'Edit Profile',
                            //tilteSize: 10,
                            buttonColor: AppColor.buttonColor,
                            onPressed: () {
                              //SnackBarCustom.build(message: 'coming soon', context: context);
                              Navigator.pushNamed(
                                  context, AppRoute.editProfile);
                            }),
                      ),
                    ],
                  )
                : const Text('You are in Offline Mode'),
          )
        ],
      ),
    );
  }
}
