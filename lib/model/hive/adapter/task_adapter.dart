import 'package:hive/hive.dart';
import '../../models/task_model.dart';


class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 5; // Unique type ID for TaskModel

  @override
  TaskModel read(BinaryReader reader) {
    return TaskModel(
      name: reader.readString(),
      type: reader.readString(),
      description: reader.readString(),
      dateAndTime: reader.readString(),
      isNew: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeString(obj.name ?? '');
    writer.writeString(obj.type ?? '');
    writer.writeString(obj.description ?? '');
    writer.writeString(obj.dateAndTime ?? '');
    writer.writeBool(obj.isNew ?? false);
  }
}