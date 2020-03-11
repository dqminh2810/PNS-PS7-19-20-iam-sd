import 'dart:ui';
import 'package:ps7_iam_sd/Pages/OrganizerHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();

  TextEditingController _userNameController = new TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _password = '';
  var _username = '';
  var _isShowPwd = false;
  var _isShowClear = false;

  @override
  void initState() {
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
    _userNameController.addListener((){
      print(_userNameController.text);

      if (_userNameController.text.length > 0) {
        _isShowClear = true;
      }else{
        _isShowClear = false;
      }
      setState(() {

      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
    super.dispose();
  }

  Future<Null> _focusNodeListener() async{
    if(_focusNodeUserName.hasFocus){
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      _focusNodeUserName.unfocus();
    }
  }

  String validateUserName(value){
    if (value.isEmpty) {
      return 'Username can not be empty!';
    }
    return null;
  }

  String validatePassWord(value){
    if (value.isEmpty) {
      return 'Password can not be empty!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width:750,height:1334)..init(context);
    print(ScreenUtil().scaleHeight);

    Widget logoImageArea = new Container(
      alignment: Alignment.topCenter,
      // Set the picture to a circle
        child: Image.asset(
          "images/logo.png",
          height: 200,
          width: 300,
          fit: BoxFit.cover,
        ),
    );

    Widget inputTextArea = new Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white
      ),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new TextFormField(
              controller: _userNameController,
              focusNode: _focusNodeUserName,
              //Set keyboard type
              decoration: InputDecoration(
                labelText: "Username",
                hintText: "Please input your usename",
                prefixIcon: Icon(Icons.person),
                //Add clear button at the end
                suffixIcon:(_isShowClear)
                    ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: (){
                    // Clear input box content
                    _userNameController.clear();
                  },
                )
                    : null ,
              ),
              //Verify username
              validator: validateUserName,
              //Save data
              onSaved: (String value){
                _username = value;
              },
            ),
            new TextFormField(
              focusNode: _focusNodePassWord,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Please input your password",
                  prefixIcon: Icon(Icons.lock),
                  // Whether to display the password
                  suffixIcon: IconButton(
                    icon: Icon((_isShowPwd) ? Icons.visibility : Icons.visibility_off),
                    // Click to change show or hide password
                    onPressed: (){
                      setState(() {
                        _isShowPwd = !_isShowPwd;
                      });
                    },
                  )
              ),
              obscureText: !_isShowPwd,
              //Password validation
              validator:validatePassWord,
              //Save data
              onSaved: (String value){
                _password = value;
              },
            )
          ],
        ),
      ),
    );

    Widget loginButtonArea = new Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      height: 45.0,
      child: new RaisedButton(
          color: Colors.deepOrangeAccent,
        child: Text(
          "Login",
          style: Theme.of(context).primaryTextTheme.headline,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: () {
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrganizerHomePage()),
          );
        }
      ),
    );
    //Forgot password Register now
    Widget bottomArea = new Container(
      margin: EdgeInsets.only(right: 20,left: 30),
      alignment: Alignment.center,
      child:  FlatButton(
            child: Text(
              "Create account",
              style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 16.0,
              ),
            ),
            //Click to quickly register and execute the event
            onPressed: (){

            },
          )
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: new GestureDetector(
        onTap: (){
          print("Clicked on a blank area");
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();
        },
        child: new ListView(
          children: <Widget>[
            new SizedBox(height: ScreenUtil().setHeight(80),),
            logoImageArea,
            new SizedBox(height: ScreenUtil().setHeight(70),),
            inputTextArea,
            new SizedBox(height: ScreenUtil().setHeight(80),),
            loginButtonArea,
            new SizedBox(height: ScreenUtil().setHeight(60),),
            bottomArea,
          ],
        ),
      ),
    );
  }
}