import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../model/local_data/local_task_data.dart';
part 'tasko_state.dart';

class TaskoCubit extends Cubit<TaskoState> {
  TaskoCubit() : super(InitialState());

  List<LocalTask> allLocalTask = [];
  List<LocalTask> newLocalTask = [];
  List<LocalTask> completedLocalTask = [];
  // int? localTaskIndex;
  // List<String>? fixedTaskType;
  // List<String>? addedTaskType;
  // List<String> allTaskType = [];
  // LocalTask? selectedTask;

  // getLocalAllTask() {
  //   if (localAllTask != null) {
  //     print('😘😁👍localTask is aloredy here');
  //     return;
  //   } else {
  //     localAllTask = LocalTask.taskList;
  //     print('👌💕❤️  initialize New LocalTask: ${localAllTask![2].taskName}');
  //   }
  // }

  getAllLocalTask() async {
    emit(LoadingState());
    allLocalTask = [];
    newLocalTask = [];
    completedLocalTask = [];
    await Future.delayed(const Duration(milliseconds: 50));
    allLocalTask = List.from(LocalTask.taskList);
    for (var e in allLocalTask) {
      if (e.isNew == true) {
        newLocalTask.add(e);
      } else {
        completedLocalTask.add(e);
      }
    }
    print('🥵🥵🥵  New LocalTask: ${newLocalTask.length}');
    print('🥵🥵🥵  Completed LocalTask: ${completedLocalTask.length}');
    emit(SuccessState(
      localAllTask: allLocalTask,
      localNewTask: newLocalTask,
      localCompletedTask: completedLocalTask,
    ));
  }

  sortLocalTaskByTime() async {
    if (allLocalTask.isEmpty) {
      return;
    } else {
      emit(LoadingState());
      allLocalTask.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      newLocalTask = [];
      completedLocalTask = [];
      await Future.delayed(const Duration(microseconds: 50));
      for (var e in allLocalTask) {
        if (e.isNew == true) {
          newLocalTask.add(e);
        } else {
          completedLocalTask.add(e);
        }
        emit(
          SuccessState(
            localAllTask: allLocalTask,
            localNewTask: newLocalTask,
            localCompletedTask: completedLocalTask,
          ),
        );
      }
    }
  }

  // getNewAndCompleteTaskList() {
  //   print('👀👀👀 ');
  //   newLocalTask = [];
  //   completedLocalTask = [];
  //   for (var e in allLocalTask) {
  //     if (e.isNew == true) {
  //       newLocalTask.add(e);
  //     } else {
  //       completedLocalTask.add(e);
  //     }
  //   }
  //   print('🥵🥵🥵  New LocalTask: ${newLocalTask.length}');
  //   print('🥵🥵🥵  Completed LocalTask: ${completedLocalTask.length}');
  // }

  // getLocalTask({required int id}) {
  //   emit(LoadingState());
  //   for (var e in allLocalTask!) {
  //     if (e.id == id) {
  //       selectedTask = e;
  //       print('👀👀👀  selectedTask: ${selectedTask!.taskName}');
  //       break;
  //     }
  //   }
  //   emit(
  //     SuccessState(
  //       localAllTask: allLocalTask!,
  //       localNewTask: newLocalTask,
  //       localCompletedTask: completedLocalTask,
  //       selectedTask: selectedTask!,
  //     ),
  //   );
  // }

  // getLocalTaskIndex({required int index}) {
  //   localTaskIndex = index;
  //   print('🎃👺👹 LocalTaskIndex :$index');
  // }

  // getLocalUserData() {
  //   if (localUser != null) {
  //     print('😘😁👍localUser is aloredy here');
  //     return;
  //   } else {
  //     localUser = LocalUser.getLocalUserData();
  //     print('👌💕❤️  initialize New LocalUser: ${localUser!.email}');
  //   }
  // }

  /// =------------------------= Test =------------------------= ///

  /// =------------------------= Login =------------------------= ///
  // userLogin({required String email, required String password}) async {
  //   emit(LoadingState());
  //   await getLocalUserData();
  //   await getAllLocalTask();
  //   await getNewAndCompleteTaskList();
  //   await Future.delayed(
  //     const Duration(seconds: 2),
  //   );

  //   if (localUser!.email == email && localUser!.password == password) {
  //     emit(
  //       SuccessState(
  //         localAllTask: allLocalTask!,
  //         localNewTask: newLocalTask,
  //         localCompletedTask: completedLocalTask,
  //         selectedTask: selectedTask!,
  //       ),
  //     );
  //   } else {
  //     SnackBarCustom.build(
  //       message: 'Email or Password Was Wrong ',
  //       context: navigatorKey.currentState!.context,
  //     );
  //     emit(InitialState());
  //   }
  // }

  /// =------------------------= Register =---------------------------= ///

  // openRegister() {
  //   emit(RegisterState());
  // }

  /// =------------------------= Task Detail =------------------------= ///

  // submitEditTaskDetail({required LocalTask updatedTask}) {
  //   emit(LoadingState());
  //   LocalTask.editTaskDetail(updatedTask);
  //   getAllLocalTask();
  //   getNewAndCompleteTaskList();
  //   getLocalTask(id: updatedTask.id!);
  //   print(':😶‍🌫️😶‍🌫️😶‍🌫️ cubit updated task : ${selectedTask!.taskName}');
  //   emit(
  //     SuccessState(
  //       localAllTask: allLocalTask!,
  //       localNewTask: newLocalTask,
  //       localCompletedTask: completedLocalTask,
  //       selectedTask: selectedTask!,
  //     ),
  //   );
  // }

  // editTaskComplete() {
  //   emit(LoadingState());
  //   LocalTask.editTaskComplete(
  //     selectedTask: selectedTask!,
  //     editIsNew: false,
  //   );
  //   getNewAndCompleteTaskList();
  //   emit(
  //     SuccessState(
  //         localAllTask: allLocalTask!,
  //         localNewTask: newLocalTask,
  //         localCompletedTask: completedLocalTask,
  //         selectedTask: selectedTask!),
  //   );
  //   // openShowTaskDetail();
  // }

  // editTaskNotComplete() {
  //   selectedTask!.isNew = true;
  //   LocalTask.editTaskComplete(selectedTask: selectedTask!, editIsNew: true);
  //   // openShowTaskDetail();
  // }

  /// =------------------------=Add New Task  =------------------------= ///
  // addNewTask(
  //     {required String taskName,
  //     required String taskType,
  //     required String taskDescription,
  //     required String dateTime}) async {
  //   emit(LoadingState());
  //   await Future.delayed(const Duration(seconds: 1));
  //   LocalTask.addNewTask(
  //       taskName: taskName,
  //       taskType: taskType,
  //       taskDescription: taskDescription,
  //       dateTime: dateTime);
  //   getAllLocalTask();
  //   //emit(HomeState(localTask: localTask!));
  // }

  // openAddNewTask() {
  //   getTaskTypeList();
  //   emit(AddNewTaskState(taskTypeList: allTaskType!));
  // }

  /// =------------------------= Home Page =--------------------------= ///
  // openHome() async {
  //   emit(LoadingState());
  //   getLocalTask();
  //   await Future.delayed(const Duration(seconds: 1));
  //   emit(HomeState(localTask: localTask!));
  // }

  /// =------------------------= Task Type =--------------------------= ///

  // getTaskTypeList() {
  //   fixedTaskType = LocalTask.fixedTaskTypeList;
  //   addedTaskType = LocalTask.addedTaskTypeList;
  //   allTaskType = [...fixedTaskType!, ...addedTaskType!];
  // }

  // openTaskType() {
  //   getTaskTypeList();
  //   print('👾👿😈${addedTaskType}');
  //   emit(TaskTypeState(
  //     fixedTaskType: fixedTaskType!,
  //     addedTaskType: addedTaskType!,
  //   ));
  // }

  // addNewTaskType(String newTaskType) {
  //   emit(LoadingState());
  //   LocalTask.addNewTaskType(newTaskType);
  //   Future.delayed(const Duration(seconds: 1));
  //   openTaskType();
  // }

  /// =------------------------= Profile =----------------------------= ///
  // openProfile() async {
  //   emit(LoadingState());
  //   getLocalUserData();
  //   await Future.delayed(const Duration(seconds: 1));
  //   emit(ProfileState(localUser: localUser!));
  // }

  // openEditPassword() {
  //   emit(EditPasswordState());
  // }

  // openEditProfile({required LocalUser localUser}) {
  //   emit(EditProfileState(localUser: localUser));
  // }

  // submitEditPassword(
  //     {required String oldPassword,
  //     required String newPassword,
  //     required String confirmPassword}) {
  //   getLocalUserData();
  //   if (localUser!.password == oldPassword) {
  //     if (newPassword == confirmPassword) {
  //       LocalUser.editPassword(newPassword: newPassword);
  //       openProfile();
  //     } else {
  //       SnackBarCustom.build(
  //           message: 'Passwords do not match!',
  //           messageColor: AppColor.red,
  //           context: navigatorKey.currentState!.context);
  //     }
  //   } else {
  //     SnackBarCustom.build(
  //         message: 'Incorrect Password',
  //         messageColor: AppColor.red,
  //         context: navigatorKey.currentState!.context);
  //   }
  // }

  // submitEditProfile({
  //   required String fristName,
  //   required String secondName,
  //   required String lastName,
  //   required String phoneNumber,
  //   required String country,
  //   required String email,
  // }) {
  //   LocalUser.editLocalUserData(
  //     fristName: fristName,
  //     secondName: secondName,
  //     lastName: lastName,
  //     phoneNumber: phoneNumber,
  //     country: country,
  //     email: email,
  //   );
  // }

  /// =------------------------= Test Cubit =------------------------= ///

  // testCubit() async {
  //   emit(LoadingState());
  //   await Future.delayed(const Duration(seconds: 3));
  //   SnackBarCustom.build(
  //       message: 'State: $state', context: navigatorKey.currentState!.context);
  //   emit(Test2State());
  // }
}
