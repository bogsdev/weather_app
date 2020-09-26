import 'package:flutter/material.dart';
import 'package:weather_app/common/values/labels.dart';
import 'package:weather_app/core/factories/factory.dart';
import 'package:weather_app/domain/beans/user.dart';
import 'package:weather_app/domain/user/user_resource.dart';
import 'package:weather_app/presentation/common/loading_widget.dart';
import 'package:weather_app/presentation/navigation/navigation.dart';
import 'package:weather_app/presentation/navigation/routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: Factory.i.get<UserResource>().get(),
        builder: (context, s) {
          if (s.connectionState == ConnectionState.done) {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Labels.i.appTitle,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                  ),
                  ListTile(
                    title: Text(Labels.i.helloWorld),
                    onTap: () {
                      Navigation.i.closeAndNavigateTo(routes_hello_world);
                    },
                  ),
                  s.hasData == true
                      ? ListTile(
                          title: Text(Labels.i.getTheWeather),
                          onTap: () {
                            Navigation.i.closeAndNavigateTo(routes_weather);
                          },
                        )
                      : Container(),
                ],
              ),
            );
          } else {
            return LoadingWidget();
          }
        });
  }
}
