import 'package:excp_training/model/firebase/FB_field_name.dart';

class TypeModel {
  List<String>? addedList;

  TypeModel({
    required this.addedList,
  });

  TypeModel.fromFirestore(Map<String, dynamic> data) {
    addedList = List<String>.from(data[FB.typeAddedList] ?? []);
  }

  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> data = <String, dynamic>{};
    data[FB.typeAddedList] = addedList ?? [];
    return data;
  }
}
