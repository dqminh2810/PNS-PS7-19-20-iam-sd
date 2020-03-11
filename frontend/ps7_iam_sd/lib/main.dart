import 'package:ps7_iam_sd/Pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:ps7_iam_sd/Services/HttpRequestService.dart';

import 'Models/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final HttpRequestService httpRequestService = new HttpRequestService();
  static User user;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polympic',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Polympic'),
        ),
        body: Center(
          child: Login(),
        ),
      ),
    );
  }
}