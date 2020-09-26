import 'package:get_it/get_it.dart';

class Factory {
  static GetIt get i => GetIt.I;

  static T get<T>() => i<T>();

  static Future<T> getAsync<T>() => i.getAsync<T>();

  static reset() => i.reset();
}
