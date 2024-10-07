import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String?uid;
  String?image ;
  String username;
  String email;
  String?bio ;
  String tel ;

  UserModel({
    this.uid,
    required this.email,
    required this.username,
    this.bio,
    this.image,
    required this.tel
 });

  factory UserModel.fromMap(map){
  return UserModel(
    uid: map["uid"],
    email: map["email"],
    tel: map["tel"],
    username: map["username"],
    image: map["image"],
    bio: map["bio"],

   );
  }
  //sending data to the server
  Map <String,dynamic>toMap(){
    return{
      'uid':uid,
      'email':email,
      'username':username,
      'image':image,
      'bio':bio,
      'tel':tel,
    };
  }
  // 2: DATA FROM SERVER
  factory UserModel.fromSnapshot(DocumentSnapshot snap){
    var snapshot =snap.data() as Map<String,dynamic> ;

    return UserModel(
      uid: snapshot['uid'],
      username: snapshot['username'],
      email: snapshot['email'],
      tel: snapshot['tel'],
      image: snapshot['image'],
      bio: snapshot['bio'],
      

    );
  }
  // 2: DATA TO SERVER
  Map<String,dynamic> toJson()=>{
    'uid':uid,
    'email':email,
    'username':username,
    'image':image,
    'bio':bio,
    'tel':tel,
  };

  


  


}