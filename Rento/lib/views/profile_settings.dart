

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rento/model/services.dart';
import 'package:rento/model/user_model.dart';
class ProfileSettings extends StatefulWidget {
  const ProfileSettings({ Key? key }) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  late UserModel myUser ;
  User? user= FirebaseAuth.instance.currentUser; 

  @override
  void initState(){
    super.initState();
    FirebaseFirestore
    .instance.collection('users')
    .doc(user!.uid)
    .get()
    .then((value){
      myUser=UserModel.fromMap(value.data());
      setState(() {
        
      });

    });
    
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                children: [
                  InkWell(
                    child: SvgPicture.asset('assets/back1.svg',color: Colors.black,width: 30,height: 30,),
                    onTap: (){Navigator.of(context).pop();},
                  ),
                  const SizedBox(width: 120,),
                  const Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),)
                ],
              )
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                myUser.image!=null? CircleAvatar(
                  maxRadius: 35,
                  backgroundImage: CachedNetworkImageProvider(
                    myUser.image.toString()
                  ) 
                )
               :
                const CircleAvatar(
                  maxRadius: 35,
                  backgroundImage: AssetImage('assets/111.png') ,
                ),
                const SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${myUser.username}',style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    const SizedBox(height: 10,),
                    Text('${myUser.email}',style: const TextStyle(color: Colors.black54 ,fontSize: 18),)

                  ],
                )
              ],
            ),
            const SizedBox(height: 50,),
            Row(
              children: const[
                Icon(Icons.person_outline_outlined,size: 30,),
                SizedBox(width: 20,),
                Text('My Profile',style: TextStyle(fontSize: 22),)
              ],
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                SvgPicture.asset('assets/settings1.svg',color: Colors.black,height: 25,width: 25,),
                const SizedBox(width: 20,),
                const Text('Settings',style: TextStyle(fontSize: 22),)
              ],
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                SvgPicture.asset('assets/notification.svg',color: Colors.black,height: 25,width: 25,),
                const SizedBox(width: 20,),
                const Text('Notifications',style: TextStyle(fontSize: 22),)
              ],
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                SvgPicture.asset('assets/analytics.svg',color: Colors.black,height: 25,width: 25,),
                const SizedBox(width: 20,),
                const Text('Analytics',style: TextStyle(fontSize: 22),)
              ],
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                SvgPicture.asset('assets/question.svg',color: Colors.black,height: 25,width: 25,),
                const SizedBox(width: 20,),
                const Text('FAQ',style: TextStyle(fontSize: 22),)
              ],
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                SvgPicture.asset('assets/about.svg',color: Colors.black,height: 25,width: 25,),
                const SizedBox(width: 20,),
                const Text('About App',style: TextStyle(fontSize: 22),)
              ],
            ),
            const SizedBox(height: 120,), 
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                hoverColor: Colors.red,
                highlightColor: Colors.grey.shade400,
                child: SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/power3.svg',color: Colors.blue,height: 30,width: 30,),
                      const SizedBox(width: 20,),
                      const Text('Logout',style: TextStyle(fontSize: 25,color: Colors.blue,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                
                onTap: (){
                  Service().logOut(context);
                },
                autofocus: true,
              ),
            ),
            const SizedBox(height: 35,),
            
          ],
        ),
      ),
    );
  }
}