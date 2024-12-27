import 'package:dashboard_mealz/common/consts/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDataSource {
  SharedPreferencesDataSource._() : _sharedPreferences = null;

  static final SharedPreferencesDataSource _instance =
      SharedPreferencesDataSource._();

  static SharedPreferencesDataSource get instance => _instance;

  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences == null) {
      throw Exception('SharedPreferences not initialized');
    }
    return _sharedPreferences!;
  }

  Future<T> get<T>(SharedPreferencesKeys key) async {
    return _sharedPreferences?.get(key.name) as T;
  }

  Future<void> set<T>(SharedPreferencesKeys key, T value) async {
    if (value is String) {
      await _sharedPreferences?.setString(key.name, value);
    } else if (value is int) {
      await _sharedPreferences?.setInt(key.name, value);
    } else if (value is bool) {
      await _sharedPreferences?.setBool(key.name, value);
    } else if (value is double) {
      await _sharedPreferences?.setDouble(key.name, value);
    } else if (value is List<String>) {
      await _sharedPreferences?.setStringList(key.name, value);
    }
  }

  Future<void> remove(SharedPreferencesKeys key) async {
    await _sharedPreferences?.remove(key.name);
  }
}
