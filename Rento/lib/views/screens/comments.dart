import 'package:rento/model/user_model.dart';
import 'package:rento/model/services.dart';
import 'package:rento/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'comments_card.dart';
class CommentPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final  snap;
  const CommentPage({ Key? key ,required this.snap}) : super(key: key);

  @override
 State<CommentPage>createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  User?user=FirebaseAuth.instance.currentUser;
  late UserModel loggedinUser ;
  final TextEditingController _comment =TextEditingController();

  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection('users')
    .doc(user!.uid)
    .get()
    .then((value) {
      loggedinUser =UserModel.fromMap(value.data());
      setState(() {
        
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('allHouses').doc(widget.snap)
        .collection('Comments').orderBy('dateAjout',descending: true).snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return  Center(
              child: CircularProgressIndicator(color:clear,),
            );

          }else{
            return Container(
              margin: const EdgeInsets.only(top:10.0),
              
              child: Column(
                children: [
                  //widget 1 :
                  Container(
                    width: 50,
                    height: 6,
                    decoration:const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ) ,
                  ),
                  const SizedBox(height: 15,),
                  // widget 3 :
                  Expanded(
                    child: ListView.builder( 
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder:(context,index)=>CommentsCard(
                        snap:(snapshot.data as dynamic).docs[index].data()
                      ),
                    ),
                  ),
                  //widget 3 :
                  Container(
                      height: 60,
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom
                      ),
                      padding: const EdgeInsets.only(left: 16,right: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:NetworkImage('${loggedinUser.image}' ) ,
                            radius: 18,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, right: 8.0),
                              child: TextField(
                                style: TextStyle(color: dBlack),
                                controller:_comment ,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  hintText: 'Comment as ${loggedinUser.username} ...'
                                ),
                              ),
                            ),
                          ),
                          InkWell( 
                            onTap: ()async{
                              await Service().postComment(
                                widget.snap, 
                                user!.uid, 
                                _comment.text,
                                loggedinUser.username as String,
                                loggedinUser.image as String
                              );
                              _comment.clear();
                              

                            },
                            child: Container(
                              padding:const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 8,
                              ),
                              child: const Text(
                                'Post',
                                style:TextStyle(
                                  color: Colors.blueAccent,
                                ) ,
                              ),
                            ),
                          )
                        ],
                        
                      ),
                    
            
            ),
                ],
              ),
            );
          }
        }
      
      
    );
  }
}