import 'package:shared_preferences/shared_preferences.dart';

void saveToken(data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', data["user_id"]);
  await prefs.setString('token', data["jwt"]);
  await prefs.setString('userName', data["user_name"]);
}
