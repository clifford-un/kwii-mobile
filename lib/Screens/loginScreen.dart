import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './chatroom.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle style = TextStyle(fontFamily: 'Roboto', fontSize: 20.0);
  String _emailValue = "";
  String _passwordValue = "";

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      style: style,
      onChanged: (text) {
        _emailValue = text;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.vertical())),
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      onChanged: (text) {
        _passwordValue = text;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        // border:
        //     OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );

    _incrementCounter(token) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int counter = (prefs.getInt('counter') ?? 0) + 1;
      print('Pressed $counter times.');
      await prefs.setInt('counter', counter);
      await prefs.setString('token', token);
    }

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff5AA182),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          print("Boton de login oprimido");
          print("_emailValue: $_emailValue");
          print("_passwordValue: $_passwordValue");
          _incrementCounter(_emailValue);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => chatroom()));
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/images/chatting.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
