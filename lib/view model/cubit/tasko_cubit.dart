import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excp_training/constant/constant.dart';
import 'package:excp_training/main.dart';
import 'package:excp_training/view/tasks/add_new_task.dart';
import 'package:excp_training/view/widget/SnackBarCustom.dart';

import '../../model/local_data/local_task_data.dart';
import '../../model/local_data/local_user.dart';
part 'tasko_state.dart';

class TaskoCubit extends Cubit<TaskoState> {
  TaskoCubit() : super(TaskoInitial());

  LocalUser? localUser;
  List<LocalTask>? localTask;
  int? localTaskIndex;
  List<String>? fixedTaskType;
  List<String>? addedTaskType;
  List<String>? allTaskType;

  getLocalTask() {
    if (localTask != null) {
      print('😘😁👍localTask is aloredy here');
      return;
    } else {
      localTask = LocalTask.tasklist;
      print('👌💕❤️  initialize New LocalTask: ${localTask![2].taskName}');
    }
  }

  getLocalTaskIndex({required int index}) {
    localTaskIndex = index;
    print('🎃👺👹 LocalTaskIndex :$index');
  }

  getLocalUserData() {
    if (localUser != null) {
      print('😘😁👍localUser is aloredy here');
      return;
    } else {
      localUser = LocalUser.getLocalUserData();
      print('👌💕❤️  initialize New LocalUser: ${localUser!.email}');
    }
  }

  /// =------------------------= Login =------------------------= ///
  userLogin({required String email, required String password}) async {
    emit(LoadingState());
    await getLocalUserData();
    await getLocalTask();
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (localUser!.email == email && localUser!.password == password) {
      emit(HomeState(localTask: localTask!));
    } else {
      SnackBarCustom.build(
        message: 'Email or Password Was Wrong ',
        context: navigatorKey.currentState!.context,
      );
      emit(TaskoInitial());
    }
  }

  openLogin() {
    emit(TaskoInitial());
  }

  /// =------------------------= Register =---------------------------= ///

  openRegister() {
    emit(RegisterState());
  }

  /// =------------------------= Task Detail =------------------------= ///
  openShowTaskDetail() async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 1));
    getLocalTask();
    emit(ShowTaskDetailState(localTaskItem: localTask![localTaskIndex!]));
  }

  openEditTaskDetail({required LocalTask localTask}) {
    getTaskTypeList();
    emit(EditTaskDetailState(localTaskItem: localTask,taskTypeList: allTaskType!));
  }

  submitEditTaskDetail({required LocalTask updatedTask}) {
    LocalTask.editTaskDetail(localTaskIndex!, updatedTask);
  }

  editTaskComplete() {
    LocalTask.editTaskComplete(index: localTaskIndex!, isNew: false);
    // openShowTaskDetail();
  }

  editTaskNotComplete() {
    LocalTask.editTaskComplete(index: localTaskIndex!, isNew: true);
    // openShowTaskDetail();
  }

  /// =------------------------=Add New Task  =------------------------= ///
  addNewTask(
      {required String taskName,
      required String taskType,
      required String taskDescription,
      required String dateTime}) async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 1));
    LocalTask.addNewTask(
        taskName: taskName,
        taskType: taskType,
        taskDescription: taskDescription,
        dateTime: dateTime);
    getLocalTask();
    emit(HomeState(localTask: localTask!));
  }

  openAddNewTask() {
    getTaskTypeList();
    emit(AddNewTaskState(taskTypeList: allTaskType!));
  }

  /// =------------------------= Home Page =--------------------------= ///
  openHome() async {
    emit(LoadedState());
    getLocalTask();
    await Future.delayed(const Duration(seconds: 1));
    emit(HomeState(localTask: localTask!));
  }

  /// =------------------------= Task Type =--------------------------= ///

  getTaskTypeList() {
    fixedTaskType = LocalTask.fixedTaskTypeList;
    addedTaskType = LocalTask.addedTaskTypeList;
    allTaskType = [...fixedTaskType!, ...addedTaskType!];
  }


  openTaskType() {
    getTaskTypeList();
    print('👾👿😈${addedTaskType}');
    emit(TaskTypeState(
      fixedTaskType: fixedTaskType!,
      addedTaskType: addedTaskType!,
    ));
  }

  addNewTaskType(String newTaskType) {
    emit(LoadingState());
    LocalTask.addNewTaskType(newTaskType);
    Future.delayed(const Duration(seconds: 1));
    openTaskType();
  }

  /// =------------------------= Profile =----------------------------= ///
  openProfile() async {
    emit(LoadingState());
    getLocalUserData();
    await Future.delayed(const Duration(seconds: 1));
    emit(ProfileState(localUser: localUser!));
  }

  openEditPassword() {
    emit(EditPasswordState());
  }

  openEditProfile({required LocalUser localUser}) {
    emit(EditProfileState(localUser: localUser));
  }

  submitEditPassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) {
    getLocalUserData();
    if (localUser!.password == oldPassword) {
      if (newPassword == confirmPassword) {
        LocalUser.editPassword(newPassword: newPassword);
        openProfile();
      } else {
        SnackBarCustom.build(
            message: 'Passwords do not match!',
            messageColor: Constant.red,
            context: navigatorKey.currentState!.context);
      }
    } else {
      SnackBarCustom.build(
          message: 'Incorrect Password',
          messageColor: Constant.red,
          context: navigatorKey.currentState!.context);
    }
  }

  submitEditProfile({
    required String fristName,
    required String secondName,
    required String lastName,
    required String phoneNumber,
    required String country,
    required String email,
  }) {
    LocalUser.editLocalUserData(
      fristName: fristName,
      secondName: secondName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      country: country,
      email: email,
    );
  }

  /// =------------------------= Test Cubit =------------------------= ///

  testCubit() async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 3));
    SnackBarCustom.build(
        message: 'State: $state', context: navigatorKey.currentState!.context);
    emit(Test2State());
  }
}
