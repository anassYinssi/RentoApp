// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rento/model/house_model.dart';
import 'package:rento/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper{




  static Future create(UserModel user)async{

    final userCollection = FirebaseFirestore.instance.collection('users');
    final docRef = userCollection.doc();

    final newUser =UserModel(
      username: user.username,
      email: user.email,
      tel: user.tel,
      bio: user.bio,
      uid: user.uid
    ).toJson();

    try{

      await docRef.set(newUser);

    }catch(e){
      e.toString();
    }

  }

  static Stream<List<Housemodel>> read(){

    final houseCollection =FirebaseFirestore.instance.collection("allHouses");
    return 
    houseCollection
    .snapshots()
    .map((querySnapshot) => querySnapshot.docs
    .map((e) => Housemodel.fromSnapshot(e)).toList());

  }
  static Stream<List<Housemodel>> readLikes(){

    User? user =FirebaseAuth.instance.currentUser;

    final houseCollection =FirebaseFirestore.instance.collection("allHouses").where('likes',arrayContains:user!.uid );

    return 
    houseCollection
    .snapshots()
    .map((querySnapshot) => querySnapshot.docs
    .map((e) => Housemodel.fromSnapshot(e)).toList());

  }

  static Stream<List<Housemodel>> readOwnerShip(){

    User? user =FirebaseAuth.instance.currentUser;

    final collection=FirebaseFirestore.instance.collection('allHouses').where('UserID',isEqualTo: user!.uid );

    return
    collection
    .snapshots()
    .map((querySnapshot) => querySnapshot.docs
    .map((e) => Housemodel.fromSnapshot(e)).toList()
    );

  }


  static Stream<List<Housemodel>> readBestOffer(){

    final userCollection =FirebaseFirestore.instance.collection("allHouses").where('likes' , arrayContains: 1);
    return 
    userCollection
    .snapshots()
    .map((querySnapshot) => querySnapshot.docs
    .map((e) => Housemodel.fromSnapshot(e)).toList());

  }
 














}