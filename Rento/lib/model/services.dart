// ignore_for_file: await_only_futures

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rento/views/screens/Auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Service{

  CollectionReference usercol =FirebaseFirestore.instance.collection('users');
  CollectionReference housecol =FirebaseFirestore.instance.collection('allHouses');
  User?user=FirebaseAuth.instance.currentUser;

  
  /*Stream<List<Housemodel>>get getHouse{
    CollectionReference housecollection =FirebaseFirestore.instance.collection('users');
    return housecollection.snapshots().map((houses){
      return houses.docs
      .map((e) => Housemodel.fromJson((e.data()) as Map <String,dynamic> ))
      .toList();
    } 
    );


  }
*/

  Future updateProfile(String username ,String bio ,String tel ,String uid)async{
    return await usercol.doc(uid).update({
      'username':username,
      'bio' :bio,
      'tel':tel,
    });

  }

  Future updatePostInfo(String username ,String bio ,String tel ,String uid)async{
    await housecol.where('UserID',isEqualTo: uid).snapshots();


  }
Future updateProfileImage(String? image ,String uid)async{
    return await usercol.doc(uid).update({
      'image':image,
    });

  }
Future updateProper(String username ,String bio ,String tel ,String uid)async{
    return await housecol.doc(uid).update({
      'username':username,
      'bio' :bio,
      'tel':tel,
    });

  }

Future<void>likePost(String postId ,String uid,List likes)async{
  try{

    if(likes.contains(uid)){
      await housecol.doc(postId).update({
       'likes':FieldValue.arrayRemove([uid])
      });
    }else{
      await housecol.doc(postId).update({
       'likes':FieldValue.arrayUnion([uid])
      });

    }
    
  }catch(e){
    e.toString();

  }

}
Future<void>postComment(String postID,String uid,String text, String name,String profilePic )async{
  try{
    if(text.isNotEmpty){
      String commentID =const Uuid().v1();
      await housecol.doc(postID).collection('Comments').doc(commentID).set({
        'profilePic':profilePic,
        'uid':uid,
        'name':name,
        'dateAjout':DateTime.now(),
        'commentID':commentID,
        'text':text,

      });


    }else{
      Fluttertoast.showToast(msg: 'Comment field is empty');
    }

  }catch(e){
    e.toString();

  }

}
Future logOut(BuildContext context)async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove('email');
  Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>const LoginPage())));
}
Future updateEtat(String postID,bool etat)async{
    return await housecol.doc(postID).update({
      'etat':!etat,
    });

  }















}
