import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceCustom {
 static  String sharedCheckBoxKey = 'remember Me';
 static String sharedEmileKey = 'email key';
 static String sharedPasswordKey = 'password key';
  static bool? sharedPrefValue;
  static String? getSharedEmailValue;
  static String? getSharedPasswordValue;


  static setSharedSetDate(String key, dynamic data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (data is bool) {
      pref.setBool(key, data);
    } else {
      pref.setString(key, data);
    }
  }

  
}