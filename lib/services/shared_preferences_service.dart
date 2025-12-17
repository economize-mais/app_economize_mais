import 'package:shared_preferences/shared_preferences.dart';

enum SharedPreferencesEnum {
  accessToken('accessToken'),
  userModel('userModel');

  final String value;
  const SharedPreferencesEnum(this.value);
}

abstract class SharedPreferencesService {
  static Future<void> setString(SharedPreferencesEnum key, String value) async {
    final instance = await SharedPreferences.getInstance();

    await instance.setString(key.value, value);
  }

  static Future<String?> getString(SharedPreferencesEnum key) async {
    final instance = await SharedPreferences.getInstance();

    return instance.getString(key.value);
  }

  static Future<void> clearAll() async {
    final instance = await SharedPreferences.getInstance();

    await instance.clear();
  }
}
