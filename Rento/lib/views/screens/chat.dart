import 'package:flutter/material.dart';
import 'package:rento/colors.dart';
import 'package:rento/screens/chat_box.dart';
import 'package:rento/shared/delay.dart';
class Chat extends StatefulWidget {
  const Chat({ Key? key }) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool istapped=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat",style: TextStyle(color: blackColor),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: blackColor),
      ),
      body:Column(
        crossAxisAlignment:CrossAxisAlignment.start ,
        children: [
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 10),
            child:  SizedBox(
              height: 40,
              child:Card(
                color: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: InkWell(
                  onTap: ()async{
                    await delay(1000);

                  },
                  child: Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:const [
                        Text("Connected",style: TextStyle(fontWeight: FontWeight.bold),),
                        Icon(Icons.arrow_right_alt)
                      ],
                    ),
                  ),
                )
              ), 
            ),
          ),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) =>Row(
                children: [
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      const CircleAvatar(maxRadius: 26,backgroundColor: blackColor,),
                      Text("user $index")
                    ],
                  ),
                ],
              )
            ),
          
          ),
          Expanded(child:
          ListView.builder(
            itemCount: 30,
            itemBuilder: (context,index)=>ListTile(
              leading: const CircleAvatar(maxRadius: 26,backgroundColor: blackColor,),
              subtitle: const Text('Vous: dernierMessage '),
              title: Text("user $index",style:const  TextStyle(fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatBox(index: index)));
              },
          )
          )
          )

        ],
      )
    );
  }
}