import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './chatmessage.dart';
import 'package:dio/dio.dart';


class chatroom extends StatefulWidget {
  @override
  _chatroomState createState() => _chatroomState();
}

class _chatroomState extends State<chatroom> {
  var _titleName;
  var _pictureProfile;
  var _message;
  var _chatroomid;
  var _username= []; 
  @override
  void initState() {
     super.initState();
    _getName();
    _getPicture();
    _getMessage();
    _getChatRoomId();


  }
  _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
      _titleName = prefs.getString('name');
    });
  }
  _getPicture() async {
     setState(() {
      _pictureProfile = "assets/images/profile_icon.png";
    });
  }
  _getMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
      _message = prefs.getString('message');
    });

  }
  _getChatRoomId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
      _chatroomid = prefs.getString('chat_room_id');
    });
  }

  _postHttp(chatroomid,message) async {
  try {
    Response response = await Dio().post("http://35.239.248.244/chats/", data: {"chat_user_origin": 2, "chat_room_id": "$chatroomid", "chat_text": "$message"});
    print(response);
  } catch (e) {
    print(e);
  }
}

 _getHttp(id) async {
  try {
    Response response = await Dio().get("http://35.247.223.67/users/$id");
    setState(() {
      _username.add(response.data['user']['user_name']);
    });
 
  } catch (e) {
    print(e);
  }
  
}

  final TextEditingController _chatController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  final String query = r"""
                    query {
                      chatById(chat_room_id: "5cf5bf4b857aba0001529206") {
                          chat_text
                          chat_user_origin
                      }
                    }
                  """;
  void _handleSubmit(String text) {
    _chatController.clear();
      ChatMessage message = new ChatMessage(
        text: text,
        name: _titleName,
        picture: _pictureProfile,

    );
    _postHttp(_chatroomid, text);
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
        title: new Text("$_titleName"),
        actions: <Widget>[
            Image(
              image: AssetImage("assets/images/chatting.png"),
            ),
          ],
      ),
      body: Query(
          options: QueryOptions( document: query,variables: <String, String>{
           '_chatroomid': 'AS',
          }),
          builder: (
            QueryResult result, {
            VoidCallback refetch,
          }) {
            if (result.loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (result.data == null) {
              return Text("No Data Found !");
            }
            _messages.clear();

            
            for (var i = 0; i < result.data['chatById'].length; i++) {
              //_getHttp(result.data['chatById'][i]['chat_user_origin']);
              ChatMessage message = new ChatMessage(
            text: result.data['chatById'][i]['chat_text'],
            name: result.data['chatById'][i]['chat_user_origin'].toString(),
            picture: _pictureProfile,
            );
             _messages.insert(0, message);      
            }

            
            print("resultado_chats: ${result.data}");
            return Column(
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
       );
      }),   
    );
  }
}
