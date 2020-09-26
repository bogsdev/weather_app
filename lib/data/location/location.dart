import 'package:location/location.dart';
import 'package:weather_app/domain/beans/location.dart';
import 'package:weather_app/domain/location/location.dart';

class LocationResourceImpl implements LocationResource {
  final Location location;

  LocationResourceImpl(this.location);

  Future<LongLat> getLocation() async {
    LocationData data = await location.getLocation();
    return LongLat(latitude: data.latitude, longitude: data.longitude);
  }

  Future<LocationPermissionStatus> getPermission() async {
    PermissionStatus status = await location.hasPermission();
    return _mapPermissionStatus(status);
  }

  Future<LocationPermissionStatus> requestPermission() async {
    PermissionStatus status = await location.requestPermission();
    return _mapPermissionStatus(status);
  }

  @override
  Future<bool> requestService() async {
    return await location.requestService();
  }

  @override
  Future<bool> serviceEnabled() async {
    return await location.serviceEnabled();
  }

  LocationPermissionStatus _mapPermissionStatus(PermissionStatus status) {
    LocationPermissionStatus perm;
    if (status == PermissionStatus.granted) {
      perm = LocationPermissionStatus.granted;
    } else if (status == PermissionStatus.deniedForever) {
      perm = LocationPermissionStatus.never_ask;
    } else {
      perm = LocationPermissionStatus.denied;
    }
    return perm;
  }
}
