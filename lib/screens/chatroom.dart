import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class chatroom extends StatefulWidget {
  @override
  _chatroomState createState() => _chatroomState();
}

class _chatroomState extends State<chatroom> {
  var _vari;

  @override
  void initState() {
     super.initState();
    _getName();
  }
  _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
      _vari = prefs.getString('name');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: new AppBar(
        // Title

        title: new Text("$_vari"),
      ),
      // Body
      body: new Container(
        // Center the content
        child: new Center(
          // Add Text
          child: new Text("Hello World!"),
        ),
      ),
    );
  }
}
