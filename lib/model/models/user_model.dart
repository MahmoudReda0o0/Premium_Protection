import 'package:excp_training/model/firebase/FB_field_name.dart';

class UserModel {
  String? fristName;
  String? secondName;
  String? lastName;
  String? phoneNumber;
  String? country;
  String? email;
  String? password;
  UserModel({
    this.fristName,
    this.secondName,
    this.lastName,
    this.phoneNumber,
    this.country,
    this.email,
    this.password,
  });

  UserModel.fromFirebase(Map<String, dynamic> data) {
    fristName = data[FB.userFristName];
    secondName = data[FB.userSecondName];
    lastName = data[FB.userLastName];
    phoneNumber = data[FB.userPhoneNumber];
    country = data[FB.userCountry];
    email = data[FB.userEmail];
    password = data[FB.userPassword];
  }

  Map<String, dynamic> toFirebase() {
    Map<String,dynamic> data = <String,dynamic>{};
    data[FB.userFristName] = fristName;
    data[FB.userSecondName] = secondName;
    data[FB.userLastName] = lastName;
    data[FB.userPhoneNumber] = phoneNumber;
    data[FB.userCountry] = country;
    data[FB.userEmail] = email;
    data[FB.userPassword] = password;
    return data;
  }
}
