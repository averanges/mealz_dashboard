class AppImages {
  AppImages._();

  static AppImages? _instance;

  static AppImages get instance => _instance ??= AppImages._();

  String get logo => 'assets/images/logo.svg';
  String get drag => 'assets/images/drag.webp';
  String get excelLogo => 'assets/images/excel_logo.png';
  String get docUpload => 'assets/images/doc_upload.webp';
  String get fileUpload => 'assets/images/file_upload.png';
}
