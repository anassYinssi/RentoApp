import 'package:rento/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class CommentsCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snap;
  const CommentsCard({ Key? key,this.snap }) : super(key: key);

  @override
  State<CommentsCard> createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePic']),
            radius: 18,
          ),
          Padding(
            padding:const EdgeInsets.only(left:16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.snap['name'],
                      style: TextStyle(fontWeight: FontWeight.bold,color: dBlack),
                    ),
                    TextSpan(
                      text:widget.snap['text'],
                      style: TextStyle(color: dBlack),

                    ),
                  
                  ]
                )
              ),
              Padding(
                padding:const EdgeInsets.only(top: 4),
                child: Text(
                  DateFormat.yMMMd().format(
                    widget.snap['dateAjout'].toDate()
                  ),

                  style:const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.grey
                  ),
                ), 
              
              )
              

            ]),
         )
        ]
      ),
      
    );
  }
}