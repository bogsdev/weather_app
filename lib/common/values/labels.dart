import 'package:weather_app/core/factories/factory.dart';

class Labels {
  String appTitle = "Weather App";
  String error = "Error";
  String pageNotFoundColon = "Page not found: ";
  String login = "Login";
  String showLocation = "Show Location";
  String latitude = "Latitude";
  String longitude = "Longitude";
  String getTheWeather = "Get the Weather";
  String weather = "Weather";
  String githubHost = "https://github.com/";
  String githubPage = "GitHub";
  String name = "Name";
  String ok = "ok";
  String loadingWithEllipses = "Loading...";
  String helloWorld = "Hello World";
  String helloWorldWithExclamationPoint = "Hello World!";

  String date = "Date (mm/dd/yyyy)";
  String temperature = "Temperature (F)";
  String description = "Description";
  String main = "Main";
  String pressure = "Pressure";
  String humidity = "Humidity";

  static Labels get i => Factory.get<Labels>();
}
