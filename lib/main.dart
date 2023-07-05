import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice/Chat.dart';
import 'package:practice/App.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final chats = await _loadChatList();

  runApp(App(chats: chats));}

Future<List<Chat>> _loadChatList() async {
  final result = <Chat>[];
  final rawData =
      jsonDecode(await rootBundle.loadString('assets/bootcamp/bootcamp.json'));
  for (final item in rawData['data']) {
    result.add(Chat.fromJson(item));}
  result.sort((a, b) {
    if (a.date == null && b.date == null) {
      return 0;
    } else if (a.date == null) {
      return 1;
    } else if (b.date == null) {
      return -1;
    } else {
      return b.date!.compareTo(a.date!);
    }
  });
  return result;
}
