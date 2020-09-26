import 'package:weather_app/common/values/labels.dart';
import 'package:weather_app/common/values/messages.dart';
import 'package:weather_app/core/errors/failed_to_authenticate.dart';
import 'package:weather_app/core/errors/failed_to_fetch_weather.dart';
import 'package:weather_app/core/errors/no_internet_exception.dart';
import 'package:weather_app/presentation/common/dialogs.dart';
import 'package:weather_app/utils/checker_utils.dart';

Future<void> showErrorDialog(Exception e, {bool showDefaultError}) async {
  String message;
  if (e is NoInternetException) {
    message = Messages.i.noInternetError;
  } else if (e is FailedToAuthenticateException) {
    message = Messages.i.failedToAuthenticate;
  } else if (e is FailedToFetchWeatherException) {
    message = Messages.i.failedToFetchWeather;
  } else if (showDefaultError == true) {
    message = Messages.i.defaultError;
  }
  if (isNotEmpty(message)) {
    String title = Labels.i.error;
    await showBasicDialog(title, message);
  }
}
