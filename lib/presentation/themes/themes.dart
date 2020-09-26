import 'package:flutter/material.dart';
import 'package:weather_app/common/values/colors.dart';
import 'package:weather_app/core/factories/factory.dart';

class Themes {
  ThemeData get theme => ThemeData(
        primaryColor: primary_color,
      );

  static Themes get i => Factory.get<Themes>();
}
