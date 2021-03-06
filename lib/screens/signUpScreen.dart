import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './chatList.dart';
import 'package:dio/dio.dart';
import './loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextStyle style = TextStyle(fontFamily: 'Roboto', fontSize: 20.0);
  String _usernameValue = "";
  String _emailValue = "";
  String _passwordValue = "";
  String _numberValue = "";
  Dio dio = new Dio();
  Response response;

  void _saveToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print("token: $token");
  }

  void _createToken(String userName, String password) async {
    try {
      response = await dio.post("http://35.245.125.167/login",
          data: {"userName": userName, "password": password});
      setState(() {
        _saveToken(response.data['jwt']);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatList()));
      });
    } catch (err) {
      print(err);
    }
  }

  void _createUser(
      String userName, String password, String email, int phoneNumber) async {
    try {
      // _isLoading = true;
      response = await dio.post("http://35.247.223.67/users", data: {
        "user_name": userName,
        "password": password,
        "e_mail": email,
        "temp": false,
        "phone_number": phoneNumber,
        "last_connection": "today"
      });
      setState(() {
        // _saveToken(response.data['jwt']);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatList()));
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => route));
      });
      // _isLoading = false;
    } catch (err) {
      // _isLoading = false;
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final usernameField = TextField(
      style: style,
      onChanged: (text) {
        _usernameValue = text;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Username",
        // border:
        //     OutlineInputBorder(borderRadius: BorderRadius.vertical())
      ),
    );

    final emailField = TextField(
      style: style,
      keyboardType: TextInputType.emailAddress,
      onChanged: (text) {
        _emailValue = text;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        // border:
        //     OutlineInputBorder(borderRadius: BorderRadius.vertical())
      ),
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

    final numberField = TextField(
      style: style,
      keyboardType: TextInputType.number,
      onChanged: (text) {
        _numberValue = text;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Number",
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

    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFFFFAC6B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          print("Boton de signUp oprimido");
          _createUser(_usernameValue, _passwordValue, _emailValue,
              int.parse(_numberValue));
        },
        child: Text("Sign Up",
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
                SizedBox(height: 20.0),
                SizedBox(height: 35.0),
                usernameField,
                SizedBox(height: 20.0),
                emailField,
                SizedBox(height: 20.0),
                passwordField,
                SizedBox(height: 20.0),
                numberField,
                SizedBox(
                  height: 35.0,
                ),
                signUpButton,
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
