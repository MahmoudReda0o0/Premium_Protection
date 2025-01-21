import 'package:hive/hive.dart';
import '../../models/task_model.dart';


class TaskModelListAdapter extends TypeAdapter<List<TaskModel>> {
  @override
  final int typeId = 3; // Unique type ID for List<TaskModel>

  @override
  List<TaskModel> read(BinaryReader reader) {
    final length = reader.readInt(); // Read the length of the list
    final taskList = <TaskModel>[];

    for (var i = 0; i < length; i++) {
      taskList.add(reader.read() as TaskModel); // Read each TaskModel
    }
    print('👽👽👽Read taskList: ${taskList.length} items');
    return taskList;
  }

  @override
  void write(BinaryWriter writer, List<TaskModel> obj) {
    writer.writeInt(obj.length); // Write the length of the list
    for (final taskModel in obj) {
      writer.write(taskModel); // Write each TaskModel
    }
    print('👽👽👽Wrote taskList: ${obj.length} items');
  }
}