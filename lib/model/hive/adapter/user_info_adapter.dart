import 'package:excp_training/model/models/user_model.dart';

import 'package:hive/hive.dart';

import '../../models/task_model.dart';

class UserInfoAdapter extends TypeAdapter<UserModel> {
  @override
  // TODO: implement typeId
  int get typeId => 1;



  @override
  UserModel read(BinaryReader reader) {
    // TODO: implement read
    return UserModel(
      fristName: reader.readString(),
      secondName: reader.readString(),
      lastName: reader.readString(),
      phoneNumber: reader.readString(),
      country: reader.readString(),
      email: reader.readString(),
      password: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    // TODO: implement write
    writer.writeString(obj.fristName ?? '');
    writer.writeString(obj.secondName ?? '');
    writer.writeString(obj.lastName ?? '');
    writer.writeString(obj.phoneNumber ?? '');
    writer.writeString(obj.country ?? '');
    writer.writeString(obj.email ?? '');
    writer.writeString(obj.password ?? '');
  }
}
