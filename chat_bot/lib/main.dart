import 'package:chat_bot/home.dart';
import 'package:flutter/material.dart';

void main(){


  runApp(const ChatBot());

}


class ChatBot extends StatelessWidget {
  const ChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true
      ),
      home: const HomeScreen(),
    );
  }
}