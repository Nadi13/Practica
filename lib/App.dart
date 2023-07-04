import 'package:practice/Chat.dart';
import 'package:flutter/material.dart';
import 'package:practice/Chats_page.dart';

class App extends StatelessWidget {
  final List<Chat> chats;

  const App({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: ChatsPage(
        chats: chats,
      ),
    );
  }
}