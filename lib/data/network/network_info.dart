import 'package:connectivity_plus/connectivity_plus.dart';

abstract class BaseNetworkInfo {
  Future<bool> checkConnection();
}

class NetworkInfo implements BaseNetworkInfo {
  final Connectivity connectivityResult;

  NetworkInfo(this.connectivityResult);

  @override
  Future<bool> checkConnection() async {
    final result = await connectivityResult.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
