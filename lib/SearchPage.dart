import 'package:practice/Chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class SearchPage extends StatefulWidget {
  final List<Chat> chats;

  const SearchPage({super.key, required this.chats});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

 class _SearchPageState extends State<SearchPage> {

  final TextEditingController controller = TextEditingController();
  List<Chat> searchResults = [];

    void runFilter(String query){
    setState(() {
      if (query.isEmpty) {
        searchResults.clear();
      } else {
        searchResults = widget.chats
            .where((contact) =>
                contact.userName.toLowerCase().contains(query.toLowerCase()) ||
                (contact.lastMessage != null &&
                    contact.lastMessage!
                        .toLowerCase()
                        .contains(query.toLowerCase())))
            .toList();
      }
    });
    }

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
        backgroundColor: Color(0xff55879F),
        title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            controller: controller,
            onChanged: (query) => runFilter(query),
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    runFilter('');
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
        body:  ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            contentPadding: EdgeInsets.only(top:10, left:10, right: 10),
            title: Text(searchResults[index].userName, style:TextStyle(fontSize: 22)),
            subtitle: searchResults[index].lastMessage != null ? 
            Text(searchResults[index].lastMessage.toString(), style:TextStyle(fontSize: 17), overflow: TextOverflow.ellipsis):null,
            leading: CircleAvatar(radius: 30,
              backgroundImage: searchResults[index].userAvatar != null ? AssetImage(searchResults[index].userAvatar.toString()): null,
              child: searchResults[index].userAvatar == null ? Stack(
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
                  Text(searchResults[index].userName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,),),],): null),
            trailing: searchResults[index].lastMessage != null ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [Text(
                formatDate(searchResults[index].date!),
                style: TextStyle(fontSize: 17),),
                SizedBox(height: 5),
              if(searchResults[index].countUnreadMessages > 0)
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,),
                  child: Center(
                    child: Text(
                    searchResults[index].countUnreadMessages.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      ),),),),],):null,
             );
        })
          );
        }
  }
  
