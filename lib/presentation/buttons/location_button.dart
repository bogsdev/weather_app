import 'package:flutter/material.dart';
import 'package:weather_app/common/values/labels.dart';
import 'package:weather_app/core/factories/factory.dart';
import 'package:weather_app/domain/beans/location.dart';
import 'package:weather_app/domain/location/location.dart';

class LocationButton extends StatefulWidget {
  @override
  _LocationButtonState createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  LongLat _longLat;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: Column(
            children: [
              RaisedButton(
                child: Text(Labels.i.showLocation),
                onPressed: () async {
                  var locationService = Factory.i.get<LocationResource>();
                  bool serviceEnabled = await locationService.serviceEnabled();
                  if (serviceEnabled != true) {
                    bool enabled = await locationService.requestService();
                    if (enabled != true) {
                      return;
                    }
                  }
                  var permission = await locationService.getPermission();
                  if (permission != LocationPermissionStatus.granted) {
                    permission = await locationService.requestPermission();
                    if (permission != LocationPermissionStatus.granted) {
                      return;
                    }
                  }
                  _longLat = await locationService.getLocation();
                  if (mounted) setState(() {});
                },
              ),
              _longLat != null
                  ? Column(
                      children: [
                        Text("${Labels.i.latitude}: ${_longLat.latitude}"),
                        Text("${Labels.i.longitude}: ${_longLat.longitude}"),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
