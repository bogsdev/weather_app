import 'package:weather_app/domain/beans/location.dart';
import 'package:weather_app/domain/beans/weather.dart';

abstract class WeatherResource {
  Future<Weather> get(LongLat longLat);
}
