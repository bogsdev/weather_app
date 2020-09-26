import 'package:weather_app/domain/beans/weather.dart';
import 'package:weather_app/utils/checker_utils.dart';

class WeatherBean extends Weather {
  WeatherBean.fromJson(Map<String, dynamic> json)
      : super(
          dateTime: DateTime.now(),
          main: isNotEmpty(json["weather"]) && json["weather"] is List
              ? (json["weather"] as List).first["main"]
              : null,
          description: isNotEmpty(json["weather"]) && json["weather"] is List
              ? (json["weather"] as List).first["description"]
              : null,
          temperature: isNotEmpty(json["main"]) && json["main"] is Map
              ? json["main"]["temp"]
              : null,
          humidity: isNotEmpty(json["main"]) && json["main"] is Map
              ? json["main"]["humidity"]
              : null,
          pressure: isNotEmpty(json["main"]) && json["main"] is Map
              ? json["main"]["pressure"]
              : null,
        );
}
