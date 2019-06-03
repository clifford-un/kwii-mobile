import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import './chatmessage.dart';



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
  final TextEditingController _chatController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmit(String text) {
    _chatController.clear();
      ChatMessage message = new ChatMessage(
        text: text
    );
      
    setState(() {
       _messages.insert(0, message);
    });
}

  Widget _chatEnvironment (){
    return IconTheme(
      data: new IconThemeData(color: Colors.blue),
          child: new Container(
        margin: const EdgeInsets.symmetric(horizontal:8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration: new InputDecoration.collapsed(hintText: "Start typing ..."),
                controller: _chatController,
                onSubmitted: _handleSubmit,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                
                onPressed: ()=> _handleSubmit(_chatController.text),
                 
              ),
            )
          ],
        ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    appBar: new AppBar(
        // Title
        elevation: 1,
        backgroundColor: Color(0xFF5AA182),
        title: new Text("$_vari"),
      ),
    body: Column(
        children: <Widget>[
          new Flexible(
            child: ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          new Divider(
            height: 1.0,
          ),
          new Container(decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: _chatEnvironment(),)
        ],
      ),
    );
  }
}
