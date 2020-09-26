import 'package:weather_app/domain/beans/user.dart';

abstract class UserResource {
  Future<User> get();

  Future<void> delete();

  Future<User> write({String name, String nickname});
}
