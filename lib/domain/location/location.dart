import 'package:weather_app/domain/beans/location.dart';

abstract class LocationResource {
  Future<LongLat> getLocation();

  Future<LocationPermissionStatus> getPermission();

  Future<LocationPermissionStatus> requestPermission();

  Future<bool> serviceEnabled();

  Future<bool> requestService();
}
