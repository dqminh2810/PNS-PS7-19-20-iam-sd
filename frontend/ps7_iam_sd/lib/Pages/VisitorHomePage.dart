import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisitorHome extends StatefulWidget {
  @override
  _VisitorHomeState createState() => _VisitorHomeState();
}

class _VisitorHomeState extends State<VisitorHome> {


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width:750,height:1334)..init(context);
    print(ScreenUtil().scaleHeight);

    Widget addButtonArea = new Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      height: 45.0,
      child: new RaisedButton(
        color: Colors.blue[300],
        child: Text(
          "Add friend",
          style: Theme.of(context).primaryTextTheme.headline,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: (){

        },
      ),
    );

    Widget findFriendButtonArea = new Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      height: 45.0,
      child: new RaisedButton(
        color: Colors.blue[300],
        child: Text(
          "Find my friends",
          style: Theme.of(context).primaryTextTheme.headline,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: (){
        },
      ),
    );

    Widget findEventButtonArea = new Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      height: 45.0,
      child: new RaisedButton(
        color: Colors.blue[300],
        child: Text(
          "Find events nearby",
          style: Theme.of(context).primaryTextTheme.headline,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: (){
        },
      ),
    );

    Widget favoriteButtonArea = new Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      height: 45.0,
      child: new RaisedButton(
        color: Colors.blue[300],
        child: Text(
          "My favorites",
          style: Theme.of(context).primaryTextTheme.headline,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: (){
        },
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: new GestureDetector(
        child: new ListView(
          children: <Widget>[
            new SizedBox(height: ScreenUtil().setHeight(80),),
            addButtonArea,
            new SizedBox(height: ScreenUtil().setHeight(80),),
            findFriendButtonArea,
            new SizedBox(height: ScreenUtil().setHeight(80),),
            findEventButtonArea,
            new SizedBox(height: ScreenUtil().setHeight(80),),
            favoriteButtonArea,
          ],
        ),
      ),
    );
  }
}