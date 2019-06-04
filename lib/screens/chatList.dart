import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './chatroom.dart';
class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {


  static List<String> dados =[
    'Dia Kurosawa',
    'Nadeko Sengoku',
  ];

  static List<String> imageses =[
    'https://static.zerochan.net/Kurosawa.Dia.full.2222565.jpg',
    'https://cdn.myanimelist.net/images/characters/2/264877.jpg',
  ];

  static List<String> testo =[
    'Quien es Nadeko?',
    'Holi cómo estas? UwU',
  ];

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
              onPressed: (){},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.message),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.more_vert),
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
        body: TabBarView(
          children: [
            //Container(color: Colors.green,), 
            Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: dados.length,
                itemBuilder: (context, index){
                  var title = dados.elementAt(index);
                  var imagese = imageses.elementAt(index);
                  var testos = testo.elementAt(index);
                  
                  return  GestureDetector(
                          onTap: (){
                            Navigator.push(
                            context, MaterialPageRoute(builder: (context) => chatroom()));
                            _saveName(title);
                            _savePicture(imagese);
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
                                padding: const EdgeInsets.only( right: 8),
                                child: Image(
                                  width: 50,
                                  height: 50,
                                  image: NetworkImage(imagese),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(testos,
                                    style: TextStyle(
                                      fontSize: 14
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: <Widget>[
                                  Text("11:45", style: TextStyle(
                                      color: Colors.green
                                  ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 4, left: 8),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(Radius.circular(100)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '1',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
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
            ),
           // Container(color: Colors.red, child: Text("Hello World!"),),
          ],
        ),
      ),
    );
  }
}
