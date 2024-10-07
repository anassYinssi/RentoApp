import 'package:flutter/material.dart';
import 'package:rento/colors.dart';
class MyMessageCard extends StatelessWidget {
  String message;
   MyMessageCard({Key? key , required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(11),
        ),
        margin: const EdgeInsets.all(8),
        child: Text(message,style: TextStyle(color: backgroundColor),),
      )
      );
  }
}