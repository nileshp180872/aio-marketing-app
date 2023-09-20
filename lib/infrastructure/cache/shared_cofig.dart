import 'package:get_storage/get_storage.dart';

mixin class SharedPreferenceConstants {
  static const kDbSyncDate = "db_sync";
  static const kToken = "token";
}

class SharedPreference {
  SharedPreference() {
    GetStorage.init();
  }

  // ------------------ Authentication Bearer Token
  /// Save authentication token.
  void saveToken(String token) =>
      GetStorage().write(SharedPreferenceConstants.kToken, token);

  String get token => GetStorage().read(SharedPreferenceConstants.kToken) ?? "";

  // ------------------ Last Sync Date
  /// Save db sync date.
  void setLastDbSyncDate(String date) {
    GetStorage().write(SharedPreferenceConstants.kDbSyncDate, date);
  }

  String get getLastDbSyncDate =>
      GetStorage().read(SharedPreferenceConstants.kDbSyncDate) ?? "";
}
