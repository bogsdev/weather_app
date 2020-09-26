import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:weather_app/common/values/labels.dart';
import 'package:weather_app/common/values/messages.dart';
import 'package:weather_app/core/errors/no_internet_exception.dart';
import 'package:weather_app/core/factories/factory.dart';
import 'package:weather_app/core/functions.dart';
import 'package:weather_app/presentation/common/dialogs.dart';

class ConnectionUtils {
  Connectivity connectivity;

  ConnectionUtils(this.connectivity);

  Future<bool> isConnectedToTheInternet() async {
    var connection = await connectivity.checkConnectivity();
    return connection == ConnectivityResult.wifi ||
        connection == ConnectivityResult.mobile;
  }

  Future<void> executeIfConnectedToInternet(FutureCallback callback) async {
    bool connected = await isConnectedToTheInternet();
    if (connected == true) {
      await callback();
    } else {
      await showBasicDialog(Labels.i.error, Messages.i.noInternetError);
    }
  }

  Future<void> requiresInternet() async {
    bool connected = await isConnectedToTheInternet();
    if (connected != true) {
      throw NoInternetException();
    }
  }

  static ConnectionUtils get i => Factory.get<ConnectionUtils>();
}
