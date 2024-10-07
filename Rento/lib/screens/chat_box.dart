// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:rento/widgets/my_message_card.dart';
import 'package:rento/widgets/sender_message_card.dart';

import '../colors.dart';

class ChatBox extends StatefulWidget {
  int index;
  ChatBox({Key? key,required this.index}) : super(key: key);

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(),
            const SizedBox(width: 5,),
            Text("user ${widget.index}",style:const TextStyle(color: blackColor),),
          ],
        ) ,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: blackColor),
      ),
      body:Column(
        children: [
          Expanded(child:
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 250,),
                MyMessageCard(message: "Afeen cv?"),
                SenderMessageCard(message: "cv"),
                SenderMessageCard(message: "hamdolah"),
               
              ],
            ),
          )
          ),
          const TextField(

          )
        ],
      ) ,

    );
  }
}