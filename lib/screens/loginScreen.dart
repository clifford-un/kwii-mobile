import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './chatList.dart';
import './signUpScreen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dio/dio.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle style = TextStyle(fontFamily: 'Roboto', fontSize: 20.0);
  Dio dio = new Dio();
  Response response;
  String _usernameValue = "";
  String _passwordValue = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _saveToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print("token: $token");
  }

  void _createToken(String userName, String password) async {
    try {
      // _isLoading = true;
      response = await dio.post("http://35.245.125.167/login",
          data: {"userName": userName, "password": password});
      setState(() {
        _saveToken(response.data['jwt']);
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

    // _incrementCounter() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   int counter = (prefs.getInt('counter') ?? 0) + 1;
    //   print('Pressed $counter times.');
    //   await prefs.setInt('counter', counter);
    //   // await prefs.setString('token', token);
    // }

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF5AA182),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          print("Boton de login oprimido");
          print("_usernameValue: $_usernameValue");
          print("_passwordValue: $_passwordValue");
          // _incrementCounter(_usernameValue);
          _createToken(_usernameValue, _passwordValue);
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final signUp = Material(
      // elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFFFFAC6B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          print("Boton de signUp oprimido");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: Text("Sign Up",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final mainScreen = SingleChildScrollView(
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
                  height: 120.0,
                  child: Image.asset(
                    "assets/images/chatting.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 35.0),
                usernameField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                signUp,
              ],
            ),
          ),
        ),
      ),
    );

    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(body: mainScreen);
    }
    // if (result.loading) {
    //   return Center(child: CircularProgressIndicator());
    // }
    // if (result.data == null) {
    //   return Text("No Data Found !");
    // }
    // print("result: ${result.data['authTest']['message']}");
  }
}
