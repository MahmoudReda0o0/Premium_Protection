import 'package:excp_training/model/firebase/FB_field_name.dart';
import 'package:excp_training/view%20model/cubit/profile/profile_cubit.dart';
import 'package:excp_training/view/profile/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../utils/app_color.dart';
import '../../utils/route/app_route.dart';
import '../../view model/cubit/general_cubit/tasko_cubit.dart';
import '../widget/LoadingPage.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/button_custom.dart';
import '../widget/error_page.dart';
import '../widget/show_date_listTile.dart';
import 'edit_profile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccess) {
          return _profileBuild(context, state);
        } else if (state is ProfileLoading) {
          return const LoadingPage();
        } else if (state is ProfileError) {
          return ErrorPage(
            errorMessage: state.errorMessage,
            onTap: () {
              Navigator.pop(context);
            },
          );
        } else {
          return ErrorPage(
            errorMessage: state.toString(),
          );
        }
      },
    );
  }

  Scaffold _profileBuild(BuildContext context, ProfileSuccess state) {
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
                      '${state.userInfo[FB.userFristName]} ${state.userInfo[FB.userSecondName]} ${state.userInfo[FB.userLastName]}',
                ),
                ShowDateListTile(
                    listTileTitle: 'Email ',
                    text: state.userInfo[FB.userEmail]),
                ShowDateListTile(
                    listTileTitle: 'Phone num ',
                    text: state.userInfo[FB.userPhoneNumber]),
                ShowDateListTile(
                    listTileTitle: 'Country ',
                    text: state.userInfo[FB.userCountry]),
                // ShowDateListTile(
                //     listTileTitle: 'password ', text: state.userInfo[FBCollectionName.userPassword]),
              ],
            ),
          ),
          Gap(50),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: ButtonCustom.build(
                      title: 'Edit Password ',
                      tilteSize: 19,
                      buttonColor: AppColor.orangeWhite,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.editPassword);
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
                        Navigator.pushNamed(context, AppRoute.editProfile);
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
