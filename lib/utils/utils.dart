import 'package:connectivity_plus/connectivity_plus.dart';

class Utils {

  /// Returns status if device has internet available.
  ///
  /// Return true if network available otherwise false.
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
