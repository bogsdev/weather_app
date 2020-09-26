import 'package:weather_app/domain/beans/user.dart';
import 'package:weather_app/domain/user/user_resource.dart';
import 'package:weather_app/io/preferences/preferences.dart';
import 'package:weather_app/io/preferences/preferences_keys.dart';
import 'package:weather_app/utils/checker_utils.dart';

class UserResourceImpl implements UserResource {
  Future<User> get() async {
    String name;
    String nickname = await Preferences.i.readString(PREF_USER_NICK_NAME);
    if (isNotEmpty(nickname)) {
      name = await Preferences.i.readString(PREF_USER_NAME);
      return User(name: name, nickname: nickname);
    }
    return null;
  }

  @override
  Future<User> write({String name, String nickname}) async {
    if (isNotEmpty(nickname)) {
      await Preferences.i.save(PREF_USER_NAME, name);
      await Preferences.i.save(PREF_USER_NICK_NAME, nickname);
      return User(name: name, nickname: nickname);
    }
    return null;
  }

  @override
  Future<void> delete() async {
    await Preferences.i.save(PREF_USER_NAME, null);
    await Preferences.i.save(PREF_USER_NICK_NAME, null);
  }
}
