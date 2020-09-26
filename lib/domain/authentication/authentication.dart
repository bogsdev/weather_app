import 'package:weather_app/domain/beans/user.dart';

abstract class Authentication {
  Future<User> authenticate();
}
