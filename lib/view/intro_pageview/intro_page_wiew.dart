import 'package:excp_training/model/hive/hive_constant.dart';
import 'package:excp_training/view%20model/cubit/Internet_checker/internet_checker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../utils/app_color.dart';
import '../../utils/route/app_route.dart';
import '../../view model/cubit/general_cubit/tasko_cubit.dart';
import '../../view model/cubit/login_cubit/login_cubit.dart';
import '../widget/page_loading_state.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/page_error_state.dart';
import 'widget/page_custom.dart';

class IntroPageWiew extends StatefulWidget {
  const IntroPageWiew({super.key});

  @override
  State<IntroPageWiew> createState() => _IntroPageWiewState();
}

class _IntroPageWiewState extends State<IntroPageWiew>
    with SingleTickerProviderStateMixin {
  PageController pageController = PageController(initialPage: 0);
  List<Widget> pages = [
    PageCustom(
      imageURL: AppColor.logo_tile,
      text:
          'Add Your Task easly and fast\n sort your tasks by time \n upload your tasks to cloud',
    ),
    PageCustom(
      imageURL: AppColor.logo_tile,
      text:
          'Use TASKO online and offline mode \n temporally check on network connection \n save last copy of update in offline mode',
    ),
    PageCustom(
      imageURL: AppColor.logo_tile,
      text:
          'Use Tasko Android Widget to show your tasks in your home screen \n show your unfinished tasks ',
    ),
  ];

  bool? checkBoxValue;
  String? getSharedEmailValue;
  String? getSharedPasswordValue;

  sharedNavigate() async {
    bool isConnected = await InternetConnectionChecker.instance.hasConnection;
    BlocProvider.of<InternetCheckerCubit>(context)
        .checkOnceInternetConnection(isConnected);
    if (isConnected) {
      var hiveBox = Hive.box(HiveConstant.boxCheckLogin);
      //SharedPreferences pref = await SharedPreferences.getInstance();
      checkBoxValue = hiveBox.get(HiveConstant.keyCheckBox);
      setState(() {});
      if (checkBoxValue == true) {
        getSharedEmailValue = hiveBox.get(HiveConstant.keyEmail);
        getSharedPasswordValue = hiveBox.get(HiveConstant.keyPassword);
        BlocProvider.of<LoginCubit>(context).setEmailAndPassword(
            emailValue: getSharedEmailValue!,
            passwordValue: getSharedPasswordValue!);
        await BlocProvider.of<LoginCubit>(context).userLogin();
        var cubitState = BlocProvider.of<LoginCubit>(context).state;
        if (cubitState is LoginSuccess) {
          BlocProvider.of<TaskoCubit>(context).getFirestoreTasks();
          Navigator.pushNamed(context, AppRoute.homePage);
        } else {
          SnackBarCustom.build(
              message: 'state: $cubitState ', context: context);
        }
      } else {
        print('shared navigate value is false');
      }
    } else {
      SnackBarCustom.build(
          message: 'No Internet Connection',
          context: context,
          duration: 3,
          messageColor: AppColor.red);
    }
  }

  @override
  void initState() {
    super.initState();
    sharedNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginInitial) {
          return _pageBuild(context, pageController, pages);
        } else if (state is LoginSuccess) {
          return const Scaffold(
            backgroundColor: AppColor.buttonColor,
          );
        } else if (state is LoginLoading) {
          return const PageLoading();
        } else if (state is LoginError) {
          return PageError(
            errorMessage: state.errorMessage,
            onTap: () {
              BlocProvider.of<LoginCubit>(context).resetLoginState();
            },
          );
        } else {
          return PageError(errorMessage: state.toString());
        }
      },
    );
  }
}

Scaffold _pageBuild(
    BuildContext context, PageController pageController, List<Widget> pages) {
  return Scaffold(
    floatingActionButton: FloatingActionButton(onPressed: () async {
      print('🥵 ${pageController.page}');
      if (pageController.page == 2.0) {
        bool isConnected =
            await InternetConnectionChecker.instance.hasConnection;
        if (isConnected) {
          Navigator.pushReplacementNamed(context, AppRoute.login);
        } else {
          Navigator.pushReplacementNamed(context, AppRoute.homePage);
        }
      } else {
        pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      }
    }),
    body: PageView(controller: pageController, children: pages),
  );
}
