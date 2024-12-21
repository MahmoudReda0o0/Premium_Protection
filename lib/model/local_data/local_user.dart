class LocalUser {
  String fristName = 'Mahmoud';
  String secondName = 'Reda';
  String lastName = 'Hashem';
  int phoneNumber = 010218041473;
  String country = 'Mansoura';
  String email = 'mahmoudreda1321@gmail.com';
  String password = 'MegaXmoud#0o0';

  LocalUser(
      {required this.fristName,
      required this.secondName,
      required this.lastName,
      required this.phoneNumber,
      required this.country,
      required this.email,
      required this.password});

  LocalUser getLocalUserData() {
    return LocalUser(
      fristName: 'Mahmoud',
      secondName: 'Reda',
      lastName: 'Hashem',
      phoneNumber: 010218041473,
      country: 'Mansoura',
      email: 'mahmoudreda1321@gmail.com',
      password: 'MegaXmoud#0o0',
    );
  }
}
