import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong/latlong.dart';
import 'package:ps7_iam_sd/Models/Location.dart';
import 'package:ps7_iam_sd/Pages/VisitorInfoPage.dart';
import 'package:ps7_iam_sd/Services/HttpRequestService.dart';
import 'package:ps7_iam_sd/Models/User.dart';
import 'package:ps7_iam_sd/Services/RouteService.dart';
import 'package:ps7_iam_sd/Mocks/UserMock.dart';
import 'package:ps7_iam_sd/Mocks/EventMock.dart';

import 'dart:ui';

import 'package:rflutter_alert/rflutter_alert.dart';

class Zone1Page extends StatefulWidget {
  @override
  _Zone1PageState createState() => _Zone1PageState();
}

class _Zone1PageState extends State<Zone1Page> {
  //
   List<Marker> makers = new List(userList1.length);
   List<LatLng> predictedRoute = new List<LatLng>();
   HttpRequestService httpRequestService = new HttpRequestService();
   RouteService routeService = new RouteService();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    print(ScreenUtil().scaleHeight);
    Widget mapArea = new Container(
        child: new FlutterMap(
      options: new MapOptions(
        center: new LatLng(43.70865104999999, 7.27006005), //经纬度，注意前后顺序，用于展示中心
        zoom: 13.5,
      ),
      layers: [
        new TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c']),
        new PolylineLayerOptions(
            polylines: [
              new Polyline(
                  points: predictedRoute,
                  color: Colors.blue,
                  strokeWidth: 4
              )
            ]),
        new MarkerLayerOptions(
            markers: userList1.map((value) {
                  return Marker(
                      width: 45.0,
                      height: 45.0,
                      point: new LatLng(value["location"]["latitude"],
                          value["location"]["longitude"]),
                      builder: (context) => new Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.accessibility_new,
                                color: Colors.black,
                              ),
                              iconSize: 35,
                              tooltip: value["name"],
                            ),
                          ));
                }).toList() +
                eventList1.map((value) {
                  return Marker(
                      width: 45.0,
                      height: 45.0,
                      point: new LatLng(value["location"]["latitude"],
                          value["location"]["longitude"]),
                      builder: (context) => new Container(
                            child: IconButton(
                              icon: Icon(Icons.place, color: Colors.deepOrange),
                              iconSize: 35,
                              tooltip: value["name"],
//                                "\nDescription : " +
//                                value["description"],
                              onPressed: () {
                                print("Marker tapped");
                              },
                            ),
                          ));
                }).toList()),
      ],
    ));

    Widget visitorListArea = new Container(
        child: new ListView(
      children: userList1.map((value) {
        return Card(
            margin: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                ListTile(
                    title: Text(value["name"]), subtitle: Text(value["type"])),
                Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: RaisedButton(
                      color: Colors.deepOrangeAccent,
                      child: Text(
                        "Predict",
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () async {
                        var userName = value["name"];
                        var userType = value["type"];
                        Location userLocation = new Location(
                            value["location"]["latitude"],
                            value["location"]["longitude"]);
                        Alert(
                          context: context,
                          type: AlertType.info,
                          title: "PREDICTION RESULT",
                          desc: "Waiting for the result...",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "ACCEPT",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                        final res = await httpRequestService.getPredictionTrace(userLocation);
                        updateRoute(res, userLocation);

                        Navigator.pop(context);
                        print(res);
                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "PREDICTION SUCCESS",
                          desc: "You can view the itinerary of $userName on the map",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "ACCEPT",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                        //}
                      },

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: RaisedButton(
                        color: Colors.deepOrangeAccent,
                        child: Text(
                          "Info",
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () {
                          User u = new User(
                              value["name"],
                              value["type"],
                              value["email"],
                              value["passeword"],
                              new Location(value["location"]["latitude"],
                                  value["location"]["longitude"]),
                              value["status"]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VisitorInfoPage(
                                      user: u,
                                    )),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: RaisedButton(
                      color: Colors.deepOrangeAccent,
                      child: Text(
                        "Location",
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () {},
                    ),
                  )
                ])
              ],
            ));
      }).toList(),
    ));
    return Scaffold(
        appBar: AppBar(
          title: Text("List of users found within zone 1"),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: mapArea,
            ),
            Expanded(
              flex: 4,
              child: visitorListArea,
            )
          ],
        ));
//  return
//      mapArea;
  }


   void updateRoute(String res, Location userLocation) async {
     List<LatLng> newRoute = await routeService.getPredictedRoute(res);
     setState(()  {
       predictedRoute = newRoute;
       predictedRoute.insert(0, LatLng(userLocation.latitude, userLocation.longitude));
     });
   }


}



