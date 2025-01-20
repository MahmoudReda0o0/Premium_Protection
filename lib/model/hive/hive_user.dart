import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';



class HiveUser {
  static String boxID = 'Hive User';
}

@HiveType(typeId: 0)
class Data extends HiveObject{
  @HiveField(0)
  UserInfo? userInfo;

  @HiveField(1)
  List<String>? allTaskList;

  @HiveField(2)
  List<String>? typeList;

  Data({this.userInfo, this.allTaskList, this.typeList});
}
