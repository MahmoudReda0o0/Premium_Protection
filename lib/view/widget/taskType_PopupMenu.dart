// import 'package:flutter/material.dart';

// import '../../model/local_data/local_task_data.dart';

// class TasktypePopupmenu extends StatefulWidget {
//    TasktypePopupmenu({super.key,required this.conTaskType});
//   TextEditingController conTaskType = TextEditingController();

//   @override
//   State<TasktypePopupmenu> createState() => _TasktypePopupmenuState();
// }

// class _TasktypePopupmenuState extends State<TasktypePopupmenu> {
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//                     onSelected: (String value) {
//                       setState(() {
//                         widget.conTaskType.text = value;
//                       });
//                     },
//                     itemBuilder: (context) => List.generate(
//                       LocalTask.allTaskTypeList.length,
//                       (index) => PopupMenuItem(
//                         value: LocalTask.allTaskTypeList[index],
//                         child: Text(LocalTask.allTaskTypeList[index]),
//                       ),
//                     ),
//                   );
//   }
// }