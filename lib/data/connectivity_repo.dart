import 'package:connectivity/connectivity.dart';

class ConnectivityRepo {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return _connectionState(result);
  }

  Stream<bool> subscribeConnected() {
    return _connectivity.onConnectivityChanged
        .map((event) => _connectionState(event));
  }

  bool _connectionState(ConnectivityResult connectivityResult) {
    return [ConnectivityResult.mobile, ConnectivityResult.wifi]
        .contains(connectivityResult);
  }
}
