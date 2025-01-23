// import 'dart:math';

// import 'package:excp_training/model/models/task_model.dart';

// class LocalTask {
//   int? id;
//   String taskName;
//   String taskType;
//   String taskDescription;
//   String dateTime;
//   bool isNew;

//   LocalTask(
//       {this.id,
//       required this.taskName,
//       required this.isNew,
//       required this.dateTime,
//       required this.taskType,
//       required this.taskDescription});

//   static List<String> fixedTaskTypeList = [
//     'Work',
//     'Study',
//     'Chores',
//     'Fitness',
//     'Shopping',
//     'Travel',
//     'Health',
//     'Events',
//     'Hobbies',
//     'Finance',
//   ];
//   static List<String> addedTaskTypeList = [];

//   static List<String> allTaskTypeList = [
//     ...fixedTaskTypeList,
//     ...addedTaskTypeList
//   ];

//   static addNewTaskType(String value) {
//     addedTaskTypeList.add(value);
//   }

//   static deletaTaskType(String taskType) {
//     addedTaskTypeList.remove(taskType);
//   }

//   static List<LocalTask> taskList = [
//     LocalTask(
//         id: 1,
//         taskName: 'Complete Flutter tutorial',
//         isNew: false,
//         dateTime: '2024-12-21 / 11:34 AM',
//         taskType: 'Work',
//         taskDescription: 'Watch and practice the Flutter tutorial videos.'),
//     LocalTask(
//         id: 2,
//         taskName: 'Grocery shopping',
//         isNew: true,
//         dateTime: '2025-01-11 / 3:27 PM',
//         taskType: 'Shopping',
//         taskDescription: 'Buy vegetables, fruits, and bread.'),
//     LocalTask(
//         id: 3,
//         taskName: 'Dentist appointment',
//         isNew: false,
//         dateTime: '2025-03-14 / 8:15 AM',
//         taskType: 'Health',
//         taskDescription: 'Visit Dr. Smith for a regular check-up.'),
//     LocalTask(
//         id: 4,
//         taskName: 'Submit tax documents',
//         isNew: false,
//         dateTime: '2024-10-06 / 10:22 AM',
//         taskType: 'Finance',
//         taskDescription: 'Prepare and send all required tax forms.'),
//     LocalTask(
//         id: 5,
//         taskName: 'Birthday party',
//         isNew: true,
//         dateTime: '2025-01-25 / 6:41 PM',
//         taskType: 'Events',
//         taskDescription: 'Attend Jake’s birthday celebration.'),
//     LocalTask(
//         id: 6,
//         taskName: 'Yoga session',
//         isNew: false,
//         dateTime: '2025-02-14 / 7:04 AM',
//         taskType: 'Fitness',
//         taskDescription: 'Join the evening yoga session at the gym.'),
//     LocalTask(
//         id: 7,
//         taskName: 'Fix laptop issues',
//         isNew: true,
//         dateTime: '2025-01-02 / 1:32 PM',
//         taskType: 'Work',
//         taskDescription:
//             'Visit the repair shop to resolve performance problems.'),
//     LocalTask(
//         id: 8,
//         taskName: 'Team meeting',
//         isNew: false,
//         dateTime: '2024-11-28 / 5:10 PM',
//         taskType: 'Work',
//         taskDescription: 'Discuss the quarterly project goals.'),
//     LocalTask(
//         id: 9,
//         taskName: 'Plan holiday trip',
//         isNew: true,
//         dateTime: '2024-12-16 / 10:24 AM',
//         taskType: 'Travel',
//         taskDescription: 'Research destinations for the summer vacation.'),
//     LocalTask(
//         id: 10,
//         taskName: 'Car service',
//         isNew: false,
//         dateTime: '2025-03-11 / 4:55 PM',
//         taskType: 'Chores',
//         taskDescription: 'Take the car for its annual servicing.'),
//     LocalTask(
//         id: 11,
//         taskName: 'Weekly book club',
//         isNew: true,
//         dateTime: '2024-12-22 / 6:30 PM',
//         taskType: 'Hobbies',
//         taskDescription: 'Discuss the latest book in the reading group.'),
//     LocalTask(
//         id: 12,
//         taskName: 'Prepare presentation',
//         isNew: false,
//         dateTime: '2025-02-05 / 3:25 PM',
//         taskType: 'Work',
//         taskDescription: 'Create slides for the upcoming product launch.'),
//     LocalTask(
//         id: 13,
//         taskName: 'Gardening',
//         isNew: true,
//         dateTime: '2025-03-01 / 9:17 AM',
//         taskType: 'Hobbies',
//         taskDescription: 'Plant new flowers and trim hedges.'),
//     LocalTask(
//         id: 14,
//         taskName: 'Online course enrollment',
//         isNew: false,
//         dateTime: '2024-12-14 / 2:10 PM',
//         taskType: 'Study',
//         taskDescription: 'Sign up for the Python programming course.'),
//     LocalTask(
//         id: 15,
//         taskName: 'Visit grandparents',
//         isNew: true,
//         dateTime: '2025-01-20 / 8:53 AM',
//         taskType: 'Events',
//         taskDescription: 'Spend the weekend with grandparents.'),
//     LocalTask(
//         id: 16,
//         taskName: 'Learn to cook',
//         isNew: false,
//         dateTime: '2025-03-15 / 11:47 AM',
//         taskType: 'Hobbies',
//         taskDescription: 'Experiment with new recipes and techniques.'),
//     LocalTask(
//         id: 17,
//         taskName: 'Renew passport',
//         isNew: true,
//         dateTime: '2025-02-11 / 10:37 PM',
//         taskType: 'Travel',
//         taskDescription: 'Complete the renewal process for the upcoming trip.'),
//     LocalTask(
//         id: 18,
//         taskName: 'Organize closet',
//         isNew: false,
//         dateTime: '2024-10-25 / 3:45 PM',
//         taskType: 'Chores',
//         taskDescription: 'Sort clothes and donate unused items.'),
//     LocalTask(
//         id: 19,
//         taskName: 'Write a blog post',
//         isNew: true,
//         dateTime: '2024-11-19 / 2:05 PM',
//         taskType: 'Hobbies',
//         taskDescription: 'Create a post about favorite books of the year.'),
//     LocalTask(
//         id: 20,
//         taskName: 'Volunteer at shelter',
//         isNew: false,
//         dateTime: '2024-12-02 / 6:40 PM',
//         taskType: 'Events',
//         taskDescription: 'Help at the animal shelter for the afternoon.'),
//   ];

//   static addNewTask({
//     required String taskName,
//     required String taskType,
//     required String taskDescription,
//     required String dateTime,
//   }) {
//     taskList.add(LocalTask(
//         id: taskList.length + 1,
//         taskName: taskName,
//         isNew: true,
//         dateTime: dateTime,
//         taskType: taskType,
//         taskDescription: taskDescription));
//   }

//   static editTaskComplete({
//     required LocalTask selectedTask,
//     // required bool editIsNew,
//   }) {
//     for (var e in taskList) {
//       if (e.id == selectedTask.id) {
//         e = selectedTask;
//         // e.isNew = editIsNew;
//         break;
//       }
//     }
//   }

//   static editTaskDetail(LocalTask updatedTask) {
//     for (int i = 0; i < taskList.length; i++) {
//       if (taskList[i].id == updatedTask.id) {
//         taskList[i] = updatedTask;
//         break;
//       }
//     }
//   }

//   static deleteTask({required TaskModelID deletedTask}) {
//    // taskList.removeWhere((test) => test.id == deletedTask.id);
//     // for (int i = 0; i < taskList.length; i++) {
//     //   if (taskList[i].id == deletedTask.id) {
//     //     taskList.remove(deletedTask);
//     //     break;
//     //   }
//     // }
//   }
// }
