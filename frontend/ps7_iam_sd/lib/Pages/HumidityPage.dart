
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:battery/battery.dart';

class HumidityPage extends StatefulWidget {
  @override
  _HumidityPageState createState() => _HumidityPageState();
}

class _HumidityPageState extends State<HumidityPage> {
  static const platformH = const MethodChannel('samples.flutter.io/humidity');
  String _batteryLevel = 'Unknown battery level.';
  String _humidity = 'Unknown humidity.';

  Future<Null> _getHumidity() async {
    String humidity;
    if(defaultTargetPlatform == TargetPlatform.android){
      try {
        final String result = await platformH.invokeMethod('getHumidity');
        humidity = 'Humidity is $result % .';
      } on PlatformException catch (e) {
        humidity = "Failed to get humidity: '${e.message}'.";
      }
    }else{
      humidity = "$defaultTargetPlatform is not yet supported by this fonction .";
    }

    setState(() {
      _humidity = humidity;
    });
  }

  Future<Null> _getBatteryLevel() async {
    var battery = Battery();
    int batteryNumber = (await battery.batteryLevel);
    String batteryLevel;
    batteryLevel = 'Battery level at $batteryNumber % .';
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
      return new Material(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new RaisedButton(
                child: new Text('Get Battery Level'),
                onPressed: _getBatteryLevel,
              ),
              new Text(_batteryLevel),
              new RaisedButton(
                child: new Text('Get Humidity'),
                onPressed:_getHumidity,
              ),
              new Text(_humidity),
            ],
          ),
        ),
      );
    }
  }