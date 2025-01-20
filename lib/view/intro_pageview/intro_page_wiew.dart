import 'package:excp_training/model/hive/hive_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../utils/app_color.dart';
import '../../utils/route/app_route.dart';
import '../../view model/cubit/general_cubit/tasko_cubit.dart';
import '../../view model/cubit/login_cubit/login_cubit.dart';
import '../widget/LoadingPage.dart';
import '../widget/SnackBarCustom.dart';
import '../widget/error_page.dart';
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
    var hiveBox = Hive.box(HiveConstant.checkLoginBox);
    //SharedPreferences pref = await SharedPreferences.getInstance();
    checkBoxValue = hiveBox.get(HiveConstant.checkBoxKey);
    setState(() {});
    if (checkBoxValue == true) {
      getSharedEmailValue =
           hiveBox.get(HiveConstant.emailKey);
      getSharedPasswordValue =
           hiveBox.get(HiveConstant.passwordKey);
      BlocProvider.of<LoginCubit>(context).setEmailAndPassword(
          emailValue: getSharedEmailValue!,
          passwordValue: getSharedPasswordValue!);
      await BlocProvider.of<LoginCubit>(context).userLogin();
      var cubitState = BlocProvider.of<LoginCubit>(context).state;
      if (cubitState is LoginSuccess) {
        BlocProvider.of<TaskoCubit>(context).getFirestoreTasks();
        Navigator.pushNamed(context, AppRoute.homePage);
      } else {
        SnackBarCustom.build(message: 'state: $cubitState ', context: context);
      }
    } else {
      print('shared navigate value is false');
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
}

Scaffold _pageBuild(
    BuildContext context, PageController pageController, List<Widget> pages) {
  return Scaffold(
    floatingActionButton: FloatingActionButton(onPressed: () {
      print('🥵 ${pageController.page}');
      if (pageController.page == 2.0) {
        Navigator.pushReplacementNamed(context, AppRoute.login);
      } else {
        pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      }
    }),
    body: PageView(controller: pageController, children: pages),
  );
}
