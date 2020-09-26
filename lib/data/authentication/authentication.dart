import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:weather_app/common/values/envs.dart';
import 'package:weather_app/core/errors/failed_to_authenticate.dart';
import 'package:weather_app/domain/authentication/authentication.dart';
import 'package:weather_app/domain/beans/user.dart';
import 'package:weather_app/domain/user/user_resource.dart';
import 'package:weather_app/utils/checker_utils.dart';
import 'package:weather_app/utils/connection_utils.dart';
import 'package:weather_app/utils/utils.dart';

class AuthenticationImpl implements Authentication {
  final FlutterAppAuth appAuth;
  final UserResource userResource;

  AuthenticationImpl({@required this.appAuth, @required this.userResource});

  @override
  Future<User> authenticate() async {
    User user;
    final AuthorizationTokenResponse result =
        await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        scopes: <String>['openid', 'profile', 'offline_access'],
      ),
    );
    if (isNotEmpty(result?.idToken)) {
      Map details = Utils.parseIdToken(result.idToken);
      String nickname = details["nickname"];
      String name = details["name"];
      user = await userResource.write(name: name, nickname: nickname);
    } else {
      throw FailedToAuthenticateException();
    }

    return user;
  }
}
