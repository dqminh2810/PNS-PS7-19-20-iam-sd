import 'package:flutter/material.dart';
import 'package:ps7_iam_sd/Pages/Zone1Page.dart';
import 'package:ps7_iam_sd/Pages/Zone2Page.dart';

class PredictionZones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Prediction Page'),
        ),
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0.0, -0.9),
              child: Text(
                'CHOOSE A ZONE',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.6),
              child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.deepOrangeAccent,
                label: Container(
                  width: 250,
                  child: Text(
                    'ZONE 1 : Nice Centre Ville',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                icon: Icon(Icons.map), //`Icon` to display
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Zone1Page()),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment(0.0, -0.2),
              child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.deepOrangeAccent,
                label: Container(
                  width: 250,
                  child: Text(
                    'ZONE 2 : Campus Sophia Tech',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                icon: Icon(Icons.map), //`Icon` to display
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Zone2Page()),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.1),
              child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.deepOrangeAccent,
                label: Container(
                  width: 250,
                  child: Text(
                    'ZONE 3 : Antibes',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(fontSize: 20),
                  ),
                ), //`Text` to display
                icon: Icon(Icons.map), //`Icon` to display
                onPressed: () {
                },
              ),
            ),
          ],
        ));
  }
}

class PredictionZone1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return null;
  }
}
