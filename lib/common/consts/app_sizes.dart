class AppSizes {
  AppSizes._();

  static AppSizes? _instance;

  static AppSizes get instance => _instance ??= AppSizes._();

  double get superSmallYPadding => 5.0;
  double get smallYPadding => 10.0;
  double get mediumYPadding => 15.0;
  double get largeYPadding => 20.0;
  double get superLargeYPadding => 25.0;

  double get superSmallHPadding => 5.0;
  double get smallHPadding => 10.0;
  double get mediumHPadding => 15.0;
  double get largeHPadding => 20.0;
  double get superLargeHPadding => 25.0;
}
