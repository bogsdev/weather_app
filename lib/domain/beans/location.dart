import 'package:flutter/material.dart';

enum LocationPermissionStatus { granted, denied, never_ask }

class LongLat {
  double latitude;
  double longitude;

  LongLat({@required this.latitude, @required this.longitude});
}
