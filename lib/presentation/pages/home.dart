import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:weather_app/common/values/labels.dart';
import 'package:weather_app/core/factories/factory.dart';
import 'package:weather_app/domain/authentication/authentication.dart';
import 'package:weather_app/domain/beans/user.dart';
import 'package:weather_app/domain/user/user_resource.dart';
import 'package:weather_app/presentation/common/dialogs.dart';
import 'package:weather_app/presentation/common/error_dialogs.dart';
import 'package:weather_app/presentation/common/loading_widget.dart';
import 'package:weather_app/presentation/common/scrollable_sandwich.dart';
import 'package:weather_app/presentation/drawer/drawer.dart';
import 'package:weather_app/presentation/navigation/navigation.dart';
import 'package:weather_app/presentation/navigation/routes.dart';
import 'package:weather_app/utils/checker_utils.dart';
import 'package:weather_app/utils/connection_utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Logger _logger = Logger("HomePage");
  var _fetchUser;

  @override
  void initState() {
    super.initState();
    _fetchUser = _getUser();
  }

  Future<User> _getUser() async {
    return Factory.get<UserResource>().get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Labels.i.appTitle),
      ),
      drawer: AppDrawer(),
      body: Container(
        child: FutureBuilder<User>(
          future: _fetchUser,
          builder: (context, s) {
            if (s.connectionState == ConnectionState.done) {
              return s.data != null
                  ? ScrollableSandwich(
                      header: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 10.0),
                                    child: Text(
                                      "${Labels.i.githubPage}: ",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                  Expanded(
                                    child: isNotEmpty(s?.data?.nickname)
                                        ? Text(
                                            "${Labels.i.githubHost}${s.data.nickname}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          )
                                        : Container(),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 10.0),
                                    child: Text(
                                      "${Labels.i.name}: ",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                  Expanded(
                                    child: isNotEmpty(s?.data?.name)
                                        ? Text(s.data.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1)
                                        : Container(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      child: Container(
                        child: Center(
                          child: RaisedButton(
                            child: Text(Labels.i.getTheWeather),
                            onPressed: () =>
                                Navigation.i.navigateTo(routes_weather),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: RaisedButton(
                        child: Container(
                          child: Text(Labels.i.login),
                        ),
                        onPressed: () async {
                          try {
                            showLoadingDialog();
                            ConnectionUtils.i
                                .executeIfConnectedToInternet(() async {
                              await Factory.i
                                  .get<Authentication>()
                                  .authenticate();
                              _fetchUser = _getUser();
                              if (mounted) setState(() {});
                              Navigation.i.close();
                            });
                          } catch (e, s) {
                            Navigation.i.close();
                            _logger.severe("Error", e, s);
                            showErrorDialog(e);
                          } finally {
                            Navigation.i.close();
                          }
                        },
                      ),
                    );
            } else if (s.hasError == true) {
              return Center(
                child: IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    _fetchUser = _getUser();
                    if (mounted) setState(() {});
                  },
                ),
              );
            } else {
              return LoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
