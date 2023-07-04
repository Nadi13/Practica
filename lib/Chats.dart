import 'package:flutter/material.dart';

class Chats extends StatefulWidget
{
  const Chats({super.key});
  
   @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff55879F),
        leading: Icon(Icons.menu),
        title: Text("Telegram"),
        actions: [
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.search,size: 30))
        ],
      ),
    );
  }


  }

