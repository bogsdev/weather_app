import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_app/common/values/envs.dart';
import 'package:weather_app/data/beans/weather_bean.dart';
import 'package:weather_app/domain/beans/location.dart';
import 'package:weather_app/domain/beans/weather.dart';
import 'package:weather_app/domain/weather/weather_resource.dart';
import 'package:weather_app/io/http/http_client.dart';

class WeatherResourceImpl implements WeatherResource {
  HTTPClient client;

  WeatherResourceImpl(this.client);

  @override
  Future<Weather> get(LongLat longLat) async {
    client.client.options.baseUrl = WEATHER_BASE_URL;
    Response response = await client.client.get(WEATHER_PATH, queryParameters: {
      "lat": longLat.latitude,
      "lon": longLat.longitude,
      "appid": WEATHER_KEY
    });
    if (response.statusCode == 200) {
      return WeatherBean.fromJson(response.data);
    }
    return null;
  }
}
