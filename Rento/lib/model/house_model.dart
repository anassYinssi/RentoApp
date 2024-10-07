
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Housemodel {
  String? profileImage;
  String name;
  String ville;
  String type;
  List<String> images ;
  double priceNight;
  double? priceMonth;
  double? priceYear;
  double aire;
  String about;
  String adress;
  int bedroom;
  int shower;
  int kitchen;
  int floor;
  String postID;
  String userID;
  List<String>equipement;
  String nameProper;
  Timestamp? timePub;
  final likes;
  bool etat=false;
 
  
  //CONSTRUCTOR
  Housemodel({
    required this.userID,
    required this.postID,
    required this.name,
    required this.adress,
    required this.about,
    required this.aire,
    required this.shower,
    required this.bedroom,
    required this.images,
    required this.equipement,
    required this.kitchen,
    required this.floor,
    required this.priceNight,
    this.priceMonth,
    this.priceYear,
    required this.type,
    required this.ville,
    this.likes,
    this.profileImage,
    required this.nameProper,
    required this.etat,
    this.timePub,
    
  });
  //String Postid
  //sending data to the server
  Map <String,dynamic>toMap(){
    return{
      'timePub':DateTime.now(),
      'name':name,
      'images':images,
      'priceNight':priceNight,
      'priceMonth':priceMonth,
      'priceYear':priceYear,
      'aire':aire,
      'about':about,
      'adress':adress,
      'bedroom':bedroom,
      'shower':shower,
      'kitchen': kitchen,
      'floor':floor,
      'PostID' :postID,
      'UserID': userID,
      'Type':type,
      'equipement':equipement,
      'ville' :ville,
      'nameProper': nameProper,
      'ProfileImage':profileImage,
      'likes' :[],
      'etat':false
    };
  }
  // getting data from server
 // factory Housemodel.fromMap(Map<String,dynamic> j){

 // }
  //data from server 

  // SET DATA :
  

 // DATA FROM SERVER :

 factory Housemodel.fromSnapshot(DocumentSnapshot snap){
  var snapshot=snap.data() as Map<String,dynamic>;
  return Housemodel(
    timePub:snapshot['timePub'],
    name:snapshot['name'],
    images:snapshot['images'].map<String>((i)=> i as String).toList() ,
    equipement:snapshot['equipement'].map<String>((i)=> i as String ).toList(),
    priceNight:snapshot['priceNight'],
    priceMonth:snapshot['priceMonth'],
    priceYear:snapshot['priceYear'],
    aire:snapshot['aire'],
    about:snapshot['about'],
    adress:snapshot['adress'],
    bedroom:snapshot['bedroom'],
    shower:snapshot['shower'],
    kitchen:snapshot['kitchen'],
    postID :snapshot['PostID'],
    userID: snapshot['UserID'],
    type:snapshot['Type'],
    ville :snapshot['ville'],
    nameProper:snapshot['nameProper'],
    profileImage:snapshot['ProfileImage'],
    likes :snapshot['likes'],
    etat:snapshot['etat'], 
    floor: snapshot['floor'],
  );

 }
 

}
  
  

  




