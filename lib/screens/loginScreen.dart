import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './chatList.dart';
import './signUpScreen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle style = TextStyle(fontFamily: 'Roboto', fontSize: 20.0);
  String _usernameValue = "";
  String _passwordValue = "";

  final String query = r"""
                    query {
                      authTest {
                        message
                      }
                    }
                  """;

  

  @override
  Widget build(BuildContext context) {
    String createToken = r"""
    mutation createToken($userName: String!, $password: String!){
      createToken(user: {
        userName: $userName,
        password: $password
        }) {
        jwt
	      error
      }
    }
    """;
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

    _setToken(token) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int counter = (prefs.getInt('counter') ?? 0) + 1;
      print('Pressed $counter times.');
      await prefs.setInt('counter', counter);
      await prefs.setString('token', token);
    }

    final loginButton = Mutation(
      options: MutationOptions(
        document: createToken, // this is the mutation string you just created
        variables: <String, dynamic> {
          "userName": _usernameValue,
          "password": _passwordValue
        },
      ),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        // if (result.loading) {
        //   return Center(child: CircularProgressIndicator());
        // }
        return Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFF5AA182),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              print("Boton de login oprimido");
              print("_usernameValue: $_usernameValue");
              print("_passwordValue: $_passwordValue");
              print("result: $result");
              await runMutation({});
              // _setToken(_usernameValue);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ChatList()));
            },
            child: Text("Login",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );
      },
      // you can update the cache based on results
      // update: (Cache cache, QueryResult result) {
      //   return cache;
      // },

      // or do something with the result.data on completion
      onCompleted: (dynamic resultData) {
        print("createToken: $createToken");
        print(resultData);
      },
    );

    // final loginButton0 = Material(
    //   elevation: 5.0,
    //   borderRadius: BorderRadius.circular(30.0),
    //   color: Color(0xFF5AA182),
    //   child: MaterialButton(
    //     minWidth: MediaQuery.of(context).size.width,
    //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //     onPressed: () {
    //       print("Boton de login oprimido");
    //       print("_usernameValue: $_usernameValue");
    //       print("_passwordValue: $_passwordValue");
    //       // runMutation({});
    //       // _setToken(_usernameValue);
    //       // Navigator.push(
    //       //     context,
    //       //     MaterialPageRoute(
    //       //         builder: (context) => ChatList()));
    //     },
    //     child: Text("Login",
    //         textAlign: TextAlign.center,
    //         style: style.copyWith(
    //             color: Colors.white, fontWeight: FontWeight.bold)),
    //   ),
    // );

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

    var mainScreen = SingleChildScrollView(
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
                loginButton,
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

    return Scaffold(
        // body: Query(
        //     options: QueryOptions(document: query),
        //     builder: (
        //       QueryResult result, {
        //       VoidCallback refetch,
        //     }) {
        //       if (result.loading) {
        //         return Center(child: CircularProgressIndicator());
        //       }
        //       if (result.data == null) {
        //         return Text("No Data Found!");
        //       }
        //       print("result: ${result.data['authTest']['message']}");
        //       return mainScreen;
        //     }),

        body: mainScreen
        );
  }
}
