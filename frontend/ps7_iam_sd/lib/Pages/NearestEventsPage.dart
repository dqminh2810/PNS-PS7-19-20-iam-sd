import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ps7_iam_sd/Mocks/EventMock.dart';
import 'package:ps7_iam_sd/Models/Event.dart';

class NearestEventsPage extends StatefulWidget {
  @override
  _NearestEventsPageState createState() => _NearestEventsPageState();
}

class _NearestEventsPageState extends State<NearestEventsPage> {
  Position currentPosition =
      new Position(latitude: 43.614502, longitude: 7.07111);
  static LatLng latLng;
  double distanceA = 0.0;
  double distanceB = 0.0;
  double distanceC = 0.0;
  double distanceD = 0.0;
  double distance = 100;
  Marker marker;
  List<Event> _events = <Event>[];

  @override
  void initState() {
    super.initState();
    StreamSubscription<Position> positionStream =
        new Geolocator().getPositionStream().listen((Position position) => {
              print("LAT:" +
                  position.latitude.toString() +
                  ", \nLNG:" +
                  position.longitude.toString())
            });
    _getCurrentLocation();
    updateLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearest Events"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: new FlutterMap(
                options: new MapOptions(
                    minZoom: 16.0,
                    center: LatLng(
                        currentPosition.latitude, currentPosition.longitude)),
                layers: [
                  new TileLayerOptions(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c']),
                  new MarkerLayerOptions(
                      markers: [
                            new Marker(
                                width: 45.0,
                                height: 45.0,
                                point: new LatLng(currentPosition.latitude,
                                    currentPosition.longitude),
                                builder: (context) => new Container(
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.accessibility_new,
                                            color: Colors.black,
                                            semanticLabel: "You are here! ",
                                          ),
                                          iconSize: 35,
                                          tooltip: 'You are here',
                                          onPressed: () {
                                            print('Marker tapped!');
                                          }),
                                    )),
                          ] +
                          eventList2.map((value) {
                            var now = DateTime.now();
                            if(now.isAfter(DateTime.parse(value["startTime"]))&&now.isBefore(DateTime.parse(value["endTime"]))){
                              return Marker(
                                  width: 45.0,
                                  height: 45.0,
                                  point: new LatLng(value["location"]["latitude"],
                                      value["location"]["longitude"]),
                                  builder: (context) => new Container(
                                    child: IconButton(
                                      icon: Icon(Icons.place,
                                          color: Colors.deepOrange),
                                      iconSize: 35,
                                      tooltip: value["name"] +
                                          "\nnumber of visitors: " +
                                          value["number"],
                                      onPressed: () {
                                        print("Marker tapped");
                                      },
                                    ),
                                  ));
                            }else if(now.isAfter(DateTime.parse(value["endTime"]))){
                              return Marker(
                                  width: 45.0,
                                  height: 45.0,
                                  point: new LatLng(value["location"]["latitude"],
                                      value["location"]["longitude"]),
                                  builder: (context) => new Container(
                                    child: IconButton(
                                      icon: Icon(Icons.place,
                                          color: Colors.deepOrange),
                                      iconSize: 35,
                                      tooltip: value["name"] +
                                          " is not open." +
                                          "\nIt has finished at " +
                                          value["endTime"],
                                      onPressed: () {
                                        print("Marker tapped");
                                      },
                                    ),
                                  ));
                            }else{
                              return Marker(
                                  width: 45.0,
                                  height: 45.0,
                                  point: new LatLng(value["location"]["latitude"],
                                      value["location"]["longitude"]),
                                  builder: (context) => new Container(
                                    child: IconButton(
                                      icon: Icon(Icons.place,
                                          color: Colors.deepOrange),
                                      iconSize: 35,
                                      tooltip: value["name"] +
                                          " is not open." +
                                          "\nIt will open at " +
                                          value["startTime"],
                                      onPressed: () {
                                        print("Marker tapped");
                                      },
                                    ),
                                  ));
                            }
                          }).toList()

                      )
                ]),
          ),
          if (currentPosition != null)
            Text(
                "LAT: ${currentPosition.latitude}, LNG: ${currentPosition.longitude}"),
          Expanded(
            flex: 4,
            child: Column(
              children: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.orange,
                  child: Text(
                    "Get locations",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    _getCurrentLocation();
                    _getDistanceA();
                    _getDistanceB();
                    _getDistanceC();
                    _getDistanceD();
                    new Marker(
                        width: 45.0,
                        height: 45.0,
                        point: new LatLng(currentPosition.latitude,
                            currentPosition.longitude));
                  },
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    "The distance to event A: ${distanceA.toStringAsFixed(2)}m",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    "The distance to event B: ${distanceB.toStringAsFixed(2)}m",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    "The distance to event C: ${distanceC.toStringAsFixed(2)}m",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      "The distance to event D: ${distanceD.toStringAsFixed(2)}m",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _getCurrentLocation() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();
    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        print('denied');
        break;
      case GeolocationStatus.disabled:
      case GeolocationStatus.restricted:
        print('restricted');
        break;
      case GeolocationStatus.unknown:
        print('unknown');
        break;
      case GeolocationStatus.granted:
        await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
            .then((Position position) {
          if (position != null) {
            setState(() {
              currentPosition = position;
              latLng = LatLng(
                position.latitude,
                position.longitude,
              );
            });
          }
        }).catchError((e) {
          print(e);
        });
        break;
    }
  }

  Future _getDistanceA() async {
    distanceA = await Geolocator().distanceBetween(currentPosition.latitude,
        currentPosition.longitude, 43.616502, 7.072096);
    //result = (_currentPosition.latitude-43.616502)*(_currentPosition.latitude-43.616502) + (_currentPosition.longitude-7.072096)*(_currentPosition.longitude-7.072096);
  }

  Future _getDistanceB() async {
    distanceB = await Geolocator().distanceBetween(currentPosition.latitude,
        currentPosition.longitude, 43.615932, 7.068376);
  }

  Future _getDistanceC() async {
    distanceC = await Geolocator().distanceBetween(currentPosition.latitude,
        currentPosition.longitude, 43.614502, 7.071110);
  }

  Future _getDistanceD() async {
    distanceD = await Geolocator().distanceBetween(currentPosition.latitude,
        currentPosition.longitude, 43.614441, 7.073056);
  }

  Future _getDistance(double latitude1, double longitude1, double latitude2,
      double longitude2) async {
    distance = await Geolocator().distanceBetween(latitude1, longitude1,
        latitude2, longitude2); //    print(distance.toString());
  }

  void updateLocation() async {
    try {
      Position newPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .timeout(new Duration(seconds: 5));

      setState(() {
        currentPosition = newPosition;
      });
      _getCurrentLocation();
      _getDistanceA();
      _getDistanceB();
      _getDistanceC();
      _getDistanceD();
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Position getCurrentPosition() {
    return currentPosition;
  }

  double getDistanceA() {
    return distanceA;
  }
}
