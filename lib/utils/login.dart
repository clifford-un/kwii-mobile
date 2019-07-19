import 'package:shared_preferences/shared_preferences.dart';

void saveToken(data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', data["data"]["createToken"]["user_id"]);
  await prefs.setString('token', data["data"]["createToken"]["jwt"]);
  await prefs.setString('userName', data["data"]["createToken"]["user_name"]);
}
