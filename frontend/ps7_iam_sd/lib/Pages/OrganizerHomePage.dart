import 'package:flutter/material.dart';
import 'package:ps7_iam_sd/Pages/HumidityPage.dart';
import 'package:ps7_iam_sd/Pages/NearestEventsPage.dart';
import 'package:ps7_iam_sd/Pages/PredictionPage.dart';

class OrganizerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Organizer Home Page'),
        ),
        body: InkWell(
            child: Stack(children: <Widget>[
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Image.asset(
              "images/logo.png",
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              height: 45.0,
              child: FlatButton.icon(
                color: Colors.deepOrangeAccent,
                label: Text(
                  'My Account',
                  style: TextStyle(fontSize: 20),
                ), //`Text` to display
                icon: Icon(Icons.account_circle), //`Icon` to display
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              height: 45.0,
              child: FlatButton.icon(
                color: Colors.deepOrangeAccent,
                label: Text(
                  'Find my friends',
                  style: TextStyle(fontSize: 20),
                ), //`Text` to display
                icon: Icon(Icons.search), //`Icon` to display
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              height: 45.0,
              child: FlatButton.icon(
                color: Colors.deepOrangeAccent,
                label: Text(
                  'Find nearest events',
                  style: TextStyle(fontSize: 20),
                ), //`Text` to display
                icon: Icon(Icons.search), //`Icon` to display
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                  //Code to execute when Floating Action Button is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NearestEventsPage()),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              height: 45.0,
              child: FlatButton.icon(
                color: Colors.deepOrangeAccent,
                label: Text(
                  'Get a prediction',
                  style: TextStyle(fontSize: 20),
                ), //`Text` to display
                icon: Icon(Icons.graphic_eq), //`Icon` to display
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PredictionZones()),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              height: 45.0,
              child: FlatButton.icon(
                color: Colors.deepOrangeAccent,
                label: Text(
                  'Native fonction',
                  style: TextStyle(fontSize: 20),
                ), //`Text` to display
                icon: Icon(Icons.graphic_eq), //`Icon` to display
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HumidityPage()),
                  );
                },
              ),
            )
          ])
        ])));
  }
}
