import 'package:weather_app/core/factories/factory.dart';

class Messages {
  String noInternetError = "Please connect to the internet and try again.";
  String failedToAuthenticate =
      "Unable to authenticate you at the moment, please try again later.";
  String failedToFetchWeather =
      "Unable to get the current weather, please try again later.";
  String allowLocation =
      "Please allow location service on your device to get the weather.";
  String enableLocationService =
      "Please enable location service on your device to get the weather.";
  String defaultError = "Something went wrong, please try again later.";

  static Messages get i => Factory.get<Messages>();
}
