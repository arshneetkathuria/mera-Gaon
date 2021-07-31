import 'package:shared_preferences/shared_preferences.dart';

class CommonFunctions
{
  static setSharedPreferences(String key,String value) async{
    var pref=await SharedPreferences.getInstance();
    pref.setString(key, value);
    print("value set");
  }

  static Future<String?> getSharedPreferences(String key) async{
var pref=await SharedPreferences.getInstance();
var sharedPrefValue=pref.getString(key);
print("SharedPrefValue=$sharedPrefValue");
return sharedPrefValue;
  }


// static setFirstScreen(String key,bool value) async{
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   pref.setBool(key, value);
// }
//  static Future<bool?> checkFirstSeen(String key) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//   return pref.getBool(key);
//   }
}