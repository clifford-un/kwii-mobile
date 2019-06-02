import 'package:flutter/material.dart';

class chatroom extends StatefulWidget {
  @override
  _chatroomState createState() => _chatroomState();
}

class _chatroomState extends State<chatroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: new AppBar(
        // Title
        title: new Text("Simple Material App"),
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
