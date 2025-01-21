import 'package:hive/hive.dart';
import 'package:excp_training/model/models/type_model.dart';

class TypeListAdapter extends TypeAdapter<TypeModel> {
  @override
  final int typeId = 2; // Unique type ID for TypeModel

  @override
  TypeModel read(BinaryReader reader) {
    final addedList = reader.readList().cast<String>();
    print('Read addedList: $addedList'); // Debugging
    return TypeModel(addedList: addedList);
  }

  @override
  void write(BinaryWriter writer, TypeModel obj) {
    print('Writing addedList: ${obj.addedList}'); // Debugging
    writer.writeList(obj.addedList ?? []);
  }
}