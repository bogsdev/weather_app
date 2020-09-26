import 'package:weather_app/domain/beans/location.dart';

abstract class LocationResource {
  Future<LongLat> getLocation();

  Future<LocationPermissionStatus> locationEnabled();

  Future<void> requestPermission();

  Future<bool> serviceEnabled();

  Future<void> requestService();
}
