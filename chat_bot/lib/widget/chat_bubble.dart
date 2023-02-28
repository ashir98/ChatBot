import 'package:chat_bot/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget chatBubble({required chatText, required ChatMessageType? type}){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CircleAvatar(
        backgroundColor: Color(type==ChatMessageType.bot?0xff9575cd:0xffffffff),
        radius: 25,
        child: Icon(type==ChatMessageType.bot?FontAwesomeIcons.robot:Icons.person, color: Color(type==ChatMessageType.bot?0xffebdcfe:0xff000000),),
      ),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: type==ChatMessageType.bot? Colors.deepPurple.shade300:Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
            )
          ),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10
          ),  
          
          child: Text(
            "$chatText",
            style: TextStyle(fontSize: 18,color: Color(type==ChatMessageType.bot?0xffffffff:0xff000000)),
            overflow: TextOverflow.fade,        
          )
        ),
      ),
    ],
  );
}