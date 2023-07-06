import 'package:practice/Chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:practice/SearchPage.dart';

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
        leading:Icon(Icons.menu),
        title: Text("Telegram"),
        actions: [
            Padding(
                padding: EdgeInsets.only(right: 16),
                child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => SearchPage(chats: chats)));},
                icon: Icon(Icons.search, size: 30),),)],),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index){
          if(chats[index].lastMessage == null){
            return Container();}
          return ListTile(
            contentPadding: EdgeInsets.only(top:10, left:10, right: 10),
            title: Text(chats[index].userName, style:TextStyle(fontSize: 22)),
            subtitle: Text(chats[index].lastMessage.toString(), style:TextStyle(fontSize: 17), overflow: TextOverflow.ellipsis),
            leading: CircleAvatar(radius: 30,
              backgroundImage: chats[index].userAvatar != null ? AssetImage(chats[index].userAvatar.toString()): null,
              child: chats[index].userAvatar == null ? Stack(
                alignment: Alignment.center,
                children: [Container(
                  decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[
                            Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                            Colors.white,],),),),
                  Text(chats[index].userName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,),),],): null),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [Text(
                formatDate(chats[index].date!),
                style: TextStyle(fontSize: 17),),
                SizedBox(height: 5),
              if(chats[index].countUnreadMessages > 0)
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,),
                  child: Center(
                    child: Text(
                    chats[index].countUnreadMessages.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      ),),),),],),
             );
        })
    );
  }

}