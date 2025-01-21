import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:excp_training/main.dart';
import 'package:excp_training/model/firebase/task_data.dart';
import 'package:excp_training/model/hive/hive_fun.dart';
import 'package:excp_training/model/models/task_model.dart';
import 'package:excp_training/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../model/hive/hive_constant.dart';
import '../../../model/local/local_task_data.dart';
import '../../../utils/android_home_page/android_widget_manager.dart';
import '../../../view/widget/SnackBarCustom.dart';
part 'tasko_state.dart';

// class TaskModelID {
//   String? id;
//   TaskModel? task;

//   TaskModelID({required this.id,required this.task});
//   // TaskModelID.fromFirebase(Map<String,dynamic> data) {
//   //   id = data['FB.taskID'];
//   //   task = data['task']!=null?;
//   // }
// }
class TaskoCubit extends Cubit<TaskoState> {
  TaskoCubit() : super(InitialState());

  List<TaskModelID> allTasks = [];
  List<TaskModelID> newTasks = [];
  List<TaskModelID> completedTask = [];
  List<String> androidTasksList = [];

  Future<void> getFirestoreTasks() async {
    emit(LoadingState());
    try {
      final response = await FB_FirestoreTaskData.getTasksListData();
      if (response.success! == true) {
        allTasks = response.tasks!;
        newTasks = [];
        completedTask = [];
        androidTasksList = []; // Clear the list before adding new tasks
        for (var e in allTasks) {
          if (e.task!.isNew == true) {
            newTasks.add(e);
            androidTasksList.add(e.task!.name!);
          } else {
            completedTask.add(e);
          }
        }

        print('🥵🥵🥵  New FirestoreTask: ${newTasks.length}');
        print('🥵🥵🥵  Completed FirestoreTask: ${completedTask.length}');

        // Save tasks and update widget
        print('Saving tasks and updating widget...');
        await AndroidWidgetManager.updateAndroidWidget(androidTasksList);
        print('Widget update completed.');
        await HiveFun.setTaskModelList(allTasks);
        emit(SuccessState(
          allTask: allTasks,
          newTask: newTasks,
          completedTask: completedTask,
        ));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  // androidWidgetUpdate() async {
  //   for (var e in newTasks) {
  //     await AndroidWidgetManager.saveTask(newTasks.);
  //   }
  //   SnackBarCustom.build(
  //       context: navigatorKey.currentState!.context,
  //       message: 'Your New Tasks Saved in Android Widget',
  //       duration: 3,
  //       messageColor: AppColor.green);
  // }

  deleteTasksWithType({required String type}) async {
    emit(LoadingState());
    try {
      List<String> finishedTaskId = [];
      bool finishedTaskBool = false;
      bool unMatchType = false;
      for (var e in allTasks) {
        if (e.task!.type == type) {
          if (e.task!.isNew == false) {
            finishedTaskId.add(e.id!);
            finishedTaskBool = true;
            continue;
          } else {
            finishedTaskBool = false;
            SnackBarCustom.build(
              context: navigatorKey.currentState!.context,
              message:
                  'Error with task id: ${e.task!.name} :: Task is not completed yet',
            );
            await HiveFun.setTaskModelList(allTasks);
            emit(SuccessState(
                allTask: allTasks,
                newTask: newTasks,
                completedTask: completedTask));
            break;
          }
        } else {
          unMatchType = true;
          continue;
        }
      }
      if (unMatchType) {
        await HiveFun.setTaskModelList(allTasks);
        emit(SuccessState(
          allTask: allTasks,
          newTask: newTasks,
          completedTask: completedTask,
          deleteTaskWithType: true,
        ));
      }
      if (finishedTaskBool) {
        
        bool errorOccurred = false;
        for (var e in finishedTaskId) {
          final response = await FB_FirestoreTaskData.deleteTask(taskId: e);
          if (response.success! == true) {
            continue;
          } else {
            SnackBarCustom.build(
                context: navigatorKey.currentState!.context,
                message: 'Error with task id: ${e} :: ${response.errorMessage}',
                duration: 3,
                messageColor: AppColor.red);
            emit(ErrorState(errorMessage: response.errorMessage!));
            errorOccurred = true;
            break;
          }
        }
        if (!errorOccurred) {
          SnackBarCustom.build(
            context: navigatorKey.currentState!.context,
            message: 'you have delete : ${finishedTaskId.length} tasks',
            duration: 3,
            // messageColor: AppColor.red
          );
          await HiveFun.setTaskModelList(allTasks);
          emit(SuccessState(
              allTask: allTasks,
              newTask: newTasks,
              completedTask: completedTask,
              deleteTaskWithType: true));
        }
      } else {
        await HiveFun.setTaskModelList(allTasks);
        emit(SuccessState(
            allTask: allTasks,
            newTask: newTasks,
            completedTask: completedTask));
      }
    } catch (e) {
      emit(
        ErrorState(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  sortTaskNormal() {
    if (allTasks.isEmpty) {
      emit(ErrorState(errorMessage: 'Task list is Empty'));
      return;
    } else {
      try {
        emit(LoadingState());
        newTasks = [];
        completedTask = [];
        for (var e in allTasks) {
          if (e.task!.isNew == true) {
            newTasks.add(e);
          } else {
            completedTask.add(e);
          }
          emit(
            SuccessState(
              allTask: allTasks,
              newTask: newTasks,
              completedTask: completedTask,
            ),
          );
        }
      } catch (e) {
        emit(ErrorState(errorMessage: 'Cubit Catch Error: ${e.toString()}'));
      }
    }
  }

  sortTaskByTime() async {
    if (allTasks.isEmpty) {
      emit(ErrorState(errorMessage: 'TaskList is Empty'));
      return;
    } else {
      try {
        emit(LoadingState());
        List<TaskModelID> sortedTasks = List.from(allTasks);
        sortedTasks.sort(
            (a, b) => b.task!.dateAndTime!.compareTo(a.task!.dateAndTime!));
        newTasks = [];
        completedTask = [];
        await Future.delayed(const Duration(microseconds: 500));
        for (var e in allTasks) {
          if (e.task!.isNew == true) {
            newTasks.add(e);
          } else {
            completedTask.add(e);
          }
          emit(
            SuccessState(
              allTask: sortedTasks,
              newTask: newTasks,
              completedTask: completedTask,
            ),
          );
        }
      } catch (e) {
        emit(ErrorState(errorMessage: 'Cubit Catch Error: ${e.toString()}'));
      }
    }
  }

  // getAllLocalTask() async {
  //   emit(LoadingState());
  //   allTasks = [];
  //   newTasks = [];
  //   completedTask = [];
  //   await Future.delayed(const Duration(milliseconds: 50));
  //   allTasks = List.from(LocalTask.taskList);
  //   for (var e in allTasks) {
  //     if (e.isNew == true) {
  //       newTasks.add(e);
  //     } else {
  //       completedTask.add(e);
  //     }
  //   }
  //   print('🥵🥵🥵  New LocalTask: ${newTasks.length}');
  //   print('🥵🥵🥵  Completed LocalTask: ${completedTask.length}');
  //   emit(SuccessState(
  //     localAllTask: allTasks,
  //     localNewTask: newTasks,
  //     localCompletedTask: completedTask,
  //   ));
  // }

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
