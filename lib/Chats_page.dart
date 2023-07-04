import 'package:practice/Chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ChatsPage extends StatelessWidget {
  final List<Chat> chats;

  const ChatsPage({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime datetime){
      final today =  DateTime.now();
      final date = DateTime(datetime.year, datetime.month, datetime.day);
      final between = today.difference(date).inDays;

      if(between == 0){
        return DateFormat.Hm().format(datetime);
      } else if (between <=6){
        return DateFormat.E().format(datetime);
      } else {
        return DateFormat('d MMM').format(datetime);
      }
    }
     return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff55879F),
        leading: Icon(Icons.menu),
        title: Text("Chats"),
        actions: [
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.search,size: 30))
        ],
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index){
          if(chats[index].lastMessage == null){
            return Container();}
          return ListTile(
            contentPadding: EdgeInsets.only(top:10, left:10),
            title: Text(chats[index].userName, style:TextStyle(fontSize: 22)),
            subtitle: Text(chats[index].lastMessage.toString(), style:TextStyle(fontSize: 17)),
            leading: CircleAvatar(radius: 30,
              backgroundImage: chats[index].userAvatar != null ? AssetImage(chats[index].userAvatar.toString()): null,
              child: chats[index].userAvatar == null ? Container(
                decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: getGradient(),)): null),
            trailing: Text(formatDate(chats[index].date!), style:TextStyle(fontSize: 17)), );
        })
    );
  }
  LinearGradient getGradient(){
      Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
      Color white = Colors.white;
      return LinearGradient(
         colors: [color, white],
         stops:  [0.0, 1.0],
         begin: Alignment.bottomCenter,
         end: Alignment.topCenter,
  );
    }
}