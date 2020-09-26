import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/common/values/labels.dart';
import 'package:weather_app/common/values/messages.dart';
import 'package:weather_app/core/factories/factory.dart';
import 'package:weather_app/domain/beans/location.dart';
import 'package:weather_app/domain/beans/weather.dart';
import 'package:weather_app/domain/location/location.dart';
import 'package:weather_app/domain/weather/weather_resource.dart';
import 'package:weather_app/presentation/common/loading_widget.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  var _fetchService;

  @override
  void initState() {
    super.initState();
    _fetchService = _getService();
  }

  Future<bool> _getService() async {
    return await Factory.i.get<LocationResource>().serviceEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Labels.i.weather),
      ),
      body: FutureBuilder<bool>(
        future: _fetchService,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            if (snapshot.data == true) {
              return LocationPermissionWidget();
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await Factory.i.get<LocationResource>().requestService();
                _fetchService = _getService();
                if (mounted) setState(() {});
              });
              return Center(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      Messages.i.enableLocationService,
                      textAlign: TextAlign.center,
                    )),
              );
            }
          } else if (snapshot.hasError == true) {
            return Center(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    Messages.i.failedToFetchWeather,
                    textAlign: TextAlign.center,
                  )),
            );
          } else {
            return LoadingWidget();
          }
        },
      ),
    );
  }
}

class LocationPermissionWidget extends StatefulWidget {
  @override
  _LocationPermissionWidgetState createState() =>
      _LocationPermissionWidgetState();
}

class _LocationPermissionWidgetState extends State<LocationPermissionWidget> {
  var _fetchLocationPermission;

  @override
  void initState() {
    super.initState();
    _fetchLocationPermission = _getPermission();
  }

  Future<LocationPermissionStatus> _getPermission() async {
    return await Factory.i.get<LocationResource>().locationEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationPermissionStatus>(
      future: _fetchLocationPermission,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if (snapshot.data == LocationPermissionStatus.granted) {
            return LocationWidget();
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await Factory.i.get<LocationResource>().requestPermission();
              _fetchLocationPermission = _getPermission();
              if (mounted) setState(() {});
            });
            return Center(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    Messages.i.allowLocation,
                    textAlign: TextAlign.center,
                  )),
            );
          }
        } else if (snapshot.hasError == true) {
          return Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  Messages.i.failedToFetchWeather,
                  textAlign: TextAlign.center,
                )),
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}

class LocationWidget extends StatefulWidget {
  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  var _fetchLocation;

  @override
  void initState() {
    super.initState();
    _fetchLocation = _getLocation();
  }

  Future<LongLat> _getLocation() async {
    return await Factory.i.get<LocationResource>().getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LongLat>(
      future: _fetchLocation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return WeatherWidget(snapshot.data);
        } else if (snapshot.hasError == true ||
            (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == null)) {
          return Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  Messages.i.failedToFetchWeather,
                  textAlign: TextAlign.center,
                )),
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}

class WeatherWidget extends StatefulWidget {
  final LongLat longLat;

  WeatherWidget(this.longLat);

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  var _fetchWeather;

  @override
  void initState() {
    super.initState();
    _fetchWeather = _getWeather();
  }

  Future<Weather> _getWeather() async {
    return await Factory.i.get<WeatherResource>().get(widget.longLat);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: _fetchWeather,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return WeatherDataWidget(snapshot.data);
        } else if (snapshot.hasError == true ||
            (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == null)) {
          return Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  Messages.i.failedToFetchWeather,
                  textAlign: TextAlign.center,
                )),
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}

class WeatherDataWidget extends StatelessWidget {
  final Weather weather;

  WeatherDataWidget(this.weather);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: width > 640
          ? buildLargeDeviceGrid(context)
          : buildSmallDeviceGrid(context),
    );
  }

  Widget buildLargeDeviceGrid(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        buildLargeDeviceHeader(context),
        buildLargeDeviceWeather(context)
      ],
    );
  }

  TableRow buildLargeDeviceHeader(BuildContext context) {
    return TableRow(
      children: [
        headerText(context, Labels.i.date),
        headerText(context, Labels.i.temperature),
        headerText(context, Labels.i.description),
        headerText(context, Labels.i.main),
        headerText(context, Labels.i.pressure),
        headerText(context, Labels.i.humidity, withRight: true),
      ],
    );
  }

  TableRow buildLargeDeviceWeather(BuildContext context) {
    return TableRow(
      children: [
        valueText(context, DateFormat('MM-dd-yyyy').format(weather.dateTime)),
        valueText(context, '${weather.temperature}'),
        valueText(context, '${weather.description}'),
        valueText(context, '${weather.main}'),
        valueText(context, '${weather.pressure}'),
        valueText(context, '${weather.humidity}', withRight: true),
      ],
    );
  }

  Widget buildSmallDeviceGrid(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        buildSmallDeviceHeader(context),
        buildSmallDeviceWeather(context)
      ],
    );
  }

  TableRow buildSmallDeviceHeader(BuildContext context) {
    return TableRow(
      children: [
        headerText(context, Labels.i.date),
        headerText(context, Labels.i.temperature, withRight: true),
      ],
    );
  }

  TableRow buildSmallDeviceWeather(BuildContext context) {
    return TableRow(
      children: [
        valueText(context, DateFormat('MM-dd-yyyy').format(weather.dateTime)),
        valueText(context, '${weather.temperature}', withRight: true),
      ],
    );
  }

  Widget valueText(BuildContext context, String text, {bool withRight}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget headerText(BuildContext context, String text, {bool withRight}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }
}
