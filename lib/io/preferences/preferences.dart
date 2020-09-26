import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/factories/factory.dart';

class Preferences {
  Future<bool> save(String name, dynamic value) async {
    bool status;
    if (name != null && value != null) {
      SharedPreferences prefs = await Factory.i.getAsync();
      if (value is int) {
        status = await prefs.setInt(name, value);
      } else if (value is double) {
        status = await prefs.setDouble(name, value);
      } else if (value is bool) {
        status = await prefs.setBool(name, value);
      } else if (value is List<String>) {
        status = await prefs.setStringList(name, value);
      } else {
        status = await prefs.setString(name, "$value");
      }
    }
    return status;
  }

  Future<String> readString(String name) async {
    String string;
    if (name != null) {
      SharedPreferences prefs = await Factory.i.getAsync();
      string = prefs?.getString(name);
    }
    return string;
  }

  Future<int> readInt(String name) async {
    int num;
    if (name != null) {
      SharedPreferences prefs = await Factory.i.getAsync();
      num = prefs?.getInt(name);
    }
    return num;
  }

  Future<double> readDouble(String name) async {
    double num;
    if (name != null) {
      SharedPreferences prefs = await Factory.i.getAsync();
      num = prefs?.getDouble(name);
    }
    return num;
  }

  Future<bool> readBoolean(String name) async {
    bool boolean;
    if (name != null) {
      SharedPreferences prefs = await Factory.i.getAsync();
      boolean = prefs?.getBool(name);
    }
    return boolean;
  }

  Future<List<String>> readArrayString(String name) async {
    List<String> stringList;
    if (name != null) {
      SharedPreferences prefs = await Factory.i.getAsync();
      stringList = prefs?.getStringList(name);
    }
    return stringList;
  }

  static Preferences get i => Factory.get<Preferences>();
}
