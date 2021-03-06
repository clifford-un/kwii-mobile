import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './chatroom.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './loginScreen.dart';
import 'package:dio/dio.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  //static List<String> dados =[
  // 'Dia Kurosawa',
  // 'Nadeko Sengoku',
  //];

  //static List<String> imageses =[
  //'https://static.zerochan.net/Kurosawa.Dia.full.2222565.jpg',
  //'https://cdn.myanimelist.net/images/characters/2/264877.jpg',
  // 'https://cdn.myanimelist.net/images/characters/2/264877.jpg',
  // ];

  //static List<String> testo =[
  //  'Quien es Nadeko?',
  //  'Holi cómo estas? UwU',
  // ];

  _getInitialData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String token = prefs.getString('token');
      String userId = prefs.getString('userId');
      String userName = prefs.getString('userName');
      print("Bienvenido: $userName!\nCon ID: $userId y token: $token");
    });
  }

  @override
  void initState() {
    super.initState();
    _getInitialData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _saveName(name) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
      print("name: $name");
    }

    _savePicture(picture) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('picture', picture);
      print("name: $picture");
    }

    _saveMessage(message) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('message', message);
      print("name: $message");
    }

    _saveChatRoomId(id) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('chat_room_id', id);
    }

    _signOut() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }

    final String query = r"""
                    query{
                    getChatroomsByUser(user_id: 2){
                      name
                      id
                    }
                    }
                  """;
    return DefaultTabController(
      length: 1,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Color(0xFF5AA182),
          title: Text("KWII"),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.message),
            ),
            IconButton(
              onPressed: () {
                print("_signOut");
                _signOut();
              },
              // icon: Icon(Icons.more_vert),
              icon: Icon(Icons.exit_to_app),
            )
          ],
          bottom: TabBar(
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              //Tab(
              //text: 'Ligações'.toUpperCase(),
              //),
              Tab(
                text: "Chats".toUpperCase(),
              ),
              // Tab(
              //text: "Contatos".toUpperCase(),
              //)
            ],
          ),
        ),
        body: Query(
            options: QueryOptions(document: query),
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
              print("resultado: ${result.data['getChatroomsByUser']}");
              return Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: result.data['getChatroomsByUser'].length,
                  itemBuilder: (context, index) {
                    var title =
                        result.data['getChatroomsByUser'][index]['name'];
                    var chatRoomId =
                        result.data['getChatroomsByUser'][index]['id'];
                    //var imagese = imageses.elementAt(index);
                    var testos = "Hola!";

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => chatroom()));
                        _saveName(title);
                        // _savePicture(imagese);
                        _saveChatRoomId(chatRoomId);
                        _saveMessage(testos);
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 98,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Image(
                                      width: 50,
                                      height: 50,
                                      image: AssetImage(
                                          "assets/images/chatting.png"),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        title,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        testos,
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "11:45",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
