
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class Storage{

FirebaseStorage storage =FirebaseStorage.instance ;
CollectionReference houseref =FirebaseFirestore.instance.collection("houses");
//upload images :
Future<String> uploadImage(File image ,String fileName)async{

     Reference reference = storage.ref().child("houses").child(fileName+'_'+DateTime.now().toString());
     UploadTask uploadTask =reference.putFile(File(image.path));
     await uploadTask.whenComplete((){
       reference.getDownloadURL().toString();
     });

     return reference.getDownloadURL();

  
 }
//recuperer les posts :


 
 






}