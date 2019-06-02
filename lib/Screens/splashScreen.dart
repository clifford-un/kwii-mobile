import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './loginScreen.dart';
import './chatroom.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool isLoading = false;
  Timer _timer;

  @override
  void initState() {
    // super.initState();
    _timer = Timer(const Duration(seconds: 1), _getToken);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _getToken() async {
    var route;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String token = prefs.getString('token');
      print('Token: $token');
      if (token == null) {
        route = LoginScreen();
      } else {
        route = chatroom();
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => route));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        child: new Center(
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 155.0,
              child: Image.asset(
                "assets/images/chatting.png",
                fit: BoxFit.contain,
              ),
            ),
          ],
        )));
  }
}
