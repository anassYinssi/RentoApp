import 'package:flutter/material.dart';

import '../colors.dart';
class SenderMessageCard extends StatelessWidget {
  String message ;
  SenderMessageCard({Key? key,required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
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