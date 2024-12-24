import 'package:excp_training/view/profile/change_password.dart';

class LocalUser {
  String fristName;
  String secondName;
  String lastName;
  String phoneNumber;
  String country;
  String email;
  String password;

  LocalUser(
      {required this.fristName,
      required this.secondName,
      required this.lastName,
      required this.phoneNumber,
      required this.country,
      required this.email,
      required this.password});

  static LocalUser localUserItem = LocalUser(
      fristName: 'Mahmoud',
      secondName: 'Reda',
      lastName: 'Hashem',
      phoneNumber: '010218041473',
      country: 'Mansoura',
      // email: 'mahmoudreda1321@gmail.com',
      email: 'm',
      // password: 'megaXmoud#0o0',
      password: '112233');

  static LocalUser getLocalUserData() {
    return localUserItem;
  }

  static editPassword({required newPassword}) {
    localUserItem.password = newPassword;
  }

  static editLocalUserData({
    required String fristName,
    required secondName,
    required lastName,
    required phoneNumber,
    required country,
    required email,
  }) {
    localUserItem.fristName = fristName;
    localUserItem.secondName = secondName;
    localUserItem.lastName = lastName;
    localUserItem.email = email;
    localUserItem.phoneNumber = phoneNumber;
    localUserItem.country = country;
  }
}
