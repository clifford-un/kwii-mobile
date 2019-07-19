import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './chatList.dart';
import './signUpScreen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dio/dio.dart';
import '../utils/login.dart';
import 'package:http/http.dart' as http;

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
  var client = new http.Client();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _sendGraphql(query,variables) async {
    
    try {

      //response = await dio.post("http://jsonplaceholder.typicode.com/posts", data: {"title": "foo","body": "bar", "userId": 1});
      response = await dio.post("https://kwiiun.com/kwii_api/graphql", data: {"query": query,"variables": variables},options: Options(contentType: ContentType.parse("application/json")) );
      print("response: ${response.data}");
      await saveToken(response.data);
       setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatList()));
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => route));
      });
    }on DioError catch(e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if(e.response != null) {
      print("if Higuaran");
        print(e.response.data);
        print(e.response.headers); 
        print(e.response.request);   
    } else{
        // Something happened in setting up or sending the request that triggered an Error  
        print(e.request);  
        print(e.message);
    }  
}
  }
  
  void _createToken(String userName, String password) async {
    String query = r"""mutation createToken($username: String!, $password: String!) {
  createToken(user: {userName: $username, password: $password}) {
      jwt, user_id, user_name
  }
}""";
var variables = {"username": userName, "password": password};
    _sendGraphql(query, variables);
    print("sendgraphql");
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
