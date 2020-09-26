import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/common/values/envs.dart';
import 'package:weather_app/common/values/labels.dart';
import 'package:weather_app/common/values/messages.dart';
import 'package:weather_app/data/authentication/authentication.dart';
import 'package:weather_app/data/location/location.dart';
import 'package:weather_app/data/user/user_resource.dart';
import 'package:weather_app/data/weather/weather_resource.dart';
import 'package:weather_app/domain/authentication/authentication.dart';
import 'package:weather_app/domain/location/location.dart';
import 'package:weather_app/domain/user/user_resource.dart';
import 'package:weather_app/domain/weather/weather_resource.dart';
import 'package:weather_app/io/http/http_client.dart';
import 'package:weather_app/io/http/http_config.dart';
import 'package:weather_app/io/http/http_constants.dart';
import 'package:weather_app/io/preferences/preferences.dart';
import 'package:weather_app/io/storage/secure_storage.dart';
import 'package:weather_app/io/storage/secure_storage_impl.dart';
import 'package:weather_app/presentation/navigation/navigation.dart';
import 'package:weather_app/presentation/navigation/navigation_impl.dart';
import 'package:weather_app/presentation/navigation/routing.dart';
import 'package:weather_app/presentation/themes/themes.dart';
import 'package:weather_app/utils/connection_utils.dart';

import 'factory.dart';

Future<void> initializeFactory(Environments env) async {
  var i = Factory.i;
  i.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  i.registerFactory<Themes>(() => Themes());
  i.registerLazySingleton<Connectivity>(() => Connectivity());
  i.registerLazySingleton<Labels>(() => Labels());
  i.registerLazySingleton<Messages>(() => Messages());
  i.registerLazySingleton<Routing>(() => Routing());
  i.registerLazySingleton<Navigation>(
      () => NavigationImpl(i.get<Routing>().navigatorKey));
  i.registerLazySingleton<Preferences>(() => Preferences());
  i.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  i.registerLazySingleton<FlutterAppAuth>(() => FlutterAppAuth());
  i.registerLazySingleton<SecureStorage>(() => SecureStorageImpl(i()));
  i.registerLazySingleton<ConnectionUtils>(() => ConnectionUtils(i()));
  i.registerLazySingleton<Dio>(() => Dio());
  i.registerLazySingleton<HTTPClient>(() {
    HTTPConfig config;
    if (env == Environments.PROD) {
      config = HTTPConfig(prodHost);
    } else if (env == Environments.QA) {
      config = HTTPConfig(qaHost);
    } else {
      config = HTTPConfig(devHost);
    }
    return HTTPClient(config, i());
  });
  i.registerLazySingleton<UserResource>(() => UserResourceImpl());
  i.registerLazySingleton<Authentication>(
      () => AuthenticationImpl(appAuth: i(), userResource: i()));
  i.registerLazySingleton<Location>(() => Location());
  i.registerLazySingleton<LocationResource>(() => LocationResourceImpl(i()));
  i.registerLazySingleton<WeatherResource>(() => WeatherResourceImpl(i()));
  await i.allReady();
}
