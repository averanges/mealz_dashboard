import 'package:dashboard_mealz/core/auth_core.dart';
import 'package:dashboard_mealz/core/navigation_core.dart';
import 'package:dashboard_mealz/data/data_sources/shared_preferences.dart';
import 'package:logger/logger.dart';

class Core {
  Core._();

  static final Core _instance = Core._();

  static Core get instance => _instance;

  late final AuthCore _authCore;
  late final NavigationCore _navigationCore;
  late final SharedPreferencesDataSource _sharedPreferencesDataSource;

  final Logger _logger = Logger();

  Logger get logger => _logger;

  NavigationCore get navigationCore => _navigationCore;
  AuthCore get authCore => _authCore;

  SharedPreferencesDataSource get sharedPreferencesDataSource =>
      _sharedPreferencesDataSource;

  Future<void> init() async {
    _authCore = AuthCore.instance;
    _navigationCore = NavigationCore.instance;
    _sharedPreferencesDataSource = SharedPreferencesDataSource.instance;
    await _sharedPreferencesDataSource.init();

    await _authCore.sync();
  }
}
