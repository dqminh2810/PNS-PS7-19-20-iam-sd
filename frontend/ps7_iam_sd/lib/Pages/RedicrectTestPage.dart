

import 'package:flutter/material.dart';
import 'package:ps7_iam_sd/Pages/TestZonePage.dart';

class RedirectTestPage extends StatefulWidget {
  @override
  _RedirectTestPage createState() => _RedirectTestPage();
}

class _RedirectTestPage extends State<RedirectTestPage> {

  @override
  Widget build(BuildContext context) {

    Widget testBtn = new Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      height: 45.0,
      child: new RaisedButton(
          color: Colors.deepOrangeAccent,
          child: Text(
            "Test",
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TestZonePage()),
            );
          }
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      // Add a gesture to the outer layer to click on a blank part and recycle the keyboard
      body: new GestureDetector(
        child: new ListView(
          children: <Widget>[
            testBtn,

          ],
        ),
      ),
    );
  }

}














