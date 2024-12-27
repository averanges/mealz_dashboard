import 'package:dashboard_mealz/common/consts/enums.dart';
import 'package:dashboard_mealz/core/core.dart';
import 'package:dashboard_mealz/core/navigation_routes.dart';

class AuthCore {
  AuthCore._();

  static final AuthCore _instance = AuthCore._();

  static AuthCore get instance => _instance;

  String _initialRoute = NavigationRoutes.sign;

  String get initialRoute => _initialRoute;

  Future<void> sync() async {
    final userToken = await Core.instance.sharedPreferencesDataSource
        .get(SharedPreferencesKeys.userToken);

    UserStatus userStatus;

    Core.instance.logger.d('User Token: $userToken');

    if (userToken != null) {
      userStatus = UserStatus.loggedIn;
    } else {
      userStatus = UserStatus.loggedOut;
    }
    Core.instance.logger.d('User Status: $userStatus');
    _userStatusSwitch(userStatus);
  }

  void _userStatusSwitch(UserStatus userStatus) {
    switch (userStatus) {
      case UserStatus.loggedIn:
        _initialRoute = NavigationRoutes.home;
      case UserStatus.loggedOut:
        _initialRoute = NavigationRoutes.sign;
    }
  }
}
