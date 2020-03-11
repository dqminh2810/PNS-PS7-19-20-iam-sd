import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ps7_iam_sd/Models/User.dart';
import 'dart:ui';

// ignore: must_be_immutable
class VisitorInfoPage extends StatelessWidget {
  User user;
  VisitorInfoPage({this.user});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
      ..init(context);
    print(ScreenUtil().scaleHeight);

    Widget photoArea = new Container(
      alignment: Alignment.topCenter,
      // Set the picture to a circle
      child: Image.asset(
        "images/photo.jpg",
        height: 200,
        width: 200,
        fit: BoxFit.cover,
      ),
    );

    Widget infoArea = new Container(
      child: Column(
        children: <Widget>[
          Text(
              "name: "+user.name,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "type: "+user.type,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
              "email: "+user.email,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("User Info"),
        ),
        body: new GestureDetector(
          child: new ListView(
            children: <Widget>[
              new SizedBox(height: ScreenUtil().setHeight(150),),
              photoArea,
              new SizedBox(height: ScreenUtil().setHeight(100),),
              infoArea,
            ],
          ),
        )
    );
  }

}
