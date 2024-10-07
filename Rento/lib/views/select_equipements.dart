import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rento/model/house_model.dart';
import 'package:rento/shared/loding.dart';
import 'package:rento/shared/storage.dart';
import 'package:rento/shared/widgets/custom_button.dart';
import 'package:rento/views/screens/home_screen.dart';
import 'package:uuid/uuid.dart';

import '../model/user_model.dart';
import '../shared/constants.dart';
import '../shared/delay.dart';



class SelectEquipements extends StatefulWidget {
  static const routeName ='/SelectEquipements -screen';
  List<File> images;
  String category;
  String city;
  String title;
  double aire;
  double priceNight;
  double? priceMonth;
  double? priceYear;
  String adress;
  String about;

  SelectEquipements({Key? key,
  required this.category,
  required this.city,
  required this.images,
  required this.title,
  required this.adress,
  required this.aire,
  this.priceMonth,
  required this.priceNight,
  this.priceYear,
  required this.about
  }) : super(key: key);

  @override
  State<SelectEquipements> createState() => _SelectEquipementsState();
}

class _SelectEquipementsState extends State<SelectEquipements> with SingleTickerProviderStateMixin {

  List<String> selectedItems =[];
  int bedCount =1;
  int floorCount =1;
  int showerCount =1;
  int kitchenCount =1;
  Housemodel currentHouse=Housemodel(
    userID: '',
    postID: '',
    name: '',
    adress: '',
    about: '',
    aire: 0,
    shower: 0,
    bedroom: 0,
    images: [],
    kitchen: 0,
    floor: 0,
    priceNight: 0,
    type: '',
    ville: '', 
    nameProper: '', 
    etat: false,
    equipement: []
  );


  User?user=FirebaseAuth.instance.currentUser;
  UserModel loggedinUser= UserModel(email: '', tel: '', username: '');
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
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: Colors.deepPurple,
                height: 10,
                width: 4*MediaQuery.of(context).size.width/7,        
              ),
            ),
          ),
          const Expanded(child: Center(child: Text("Precise more features",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),)),
          Expanded(
            flex: 8,
            child: Column(
              children: [
              Expanded(child:
                Center(
                  child: Wrap(
                    runSpacing: 20,
                    children: [
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width/2,
                        child: Column(
                          children: [
                            const Text('Bedrooms',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87)),
                            const SizedBox(height: 15,),
                            incrementBedCount(),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        color: Colors.white,
                        child: Column(
                          children: [
                            const Text('Floors',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
                            const SizedBox(height: 15,),
                            incrementFloorsCount(),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width/2,
                        child: Column(
                          children: [
                            const Text('Shower',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87)),
                            const SizedBox(height: 15,),
                            incrementShowerCount(),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        color: Colors.white,
                        child: Column(
                          children: [
                            const Text('Kitchen',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87),),
                            const SizedBox(height: 15,),
                            incrementKitchenCount(),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Text('Select items (${selectedItems.length})',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Expanded(child: 
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                  itemCount: equipements.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing: 5,mainAxisSpacing: 5),
                  itemBuilder: (BuildContext context,int index){
                    return equipementItems(equipements[index].label, equipements[index].icon, equipements[index].isSelected, index);
                  }
                  ),
                )
                )
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: Row(
                children:[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 60,
                      child: CustomButton(
                        text: 'BACK',
                        onPressed: ()async{
                          await delay(200);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 60,
                      child: CustomButton(
                        text:'FINISH',
                        onPressed: ()async{
                          await delay(200);
                          loading(context);
                          currentHouse.nameProper=loggedinUser.username;
                          currentHouse.profileImage=loggedinUser.image;
                          currentHouse.name=widget.title;
                          currentHouse.adress=widget.adress;
                          currentHouse.about=widget.about;
                          currentHouse.aire=widget.aire;
                          currentHouse.priceNight=widget.priceNight;
                          currentHouse.priceMonth=widget.priceMonth;
                          currentHouse.priceYear=widget.priceYear;
                          currentHouse.ville=widget.city;
                          currentHouse.type=widget.category;
                          currentHouse.bedroom=bedCount;
                          currentHouse.floor=floorCount;
                          currentHouse.kitchen=kitchenCount;
                          currentHouse.shower=showerCount;
                          currentHouse.userID=user!.uid;
                          currentHouse.equipement=selectedItems;
                          for(var i=0;i<widget.images.length;i++){
                            String url =await Storage().uploadImage(widget.images[i], '');
                            currentHouse.images.add(url);
                          }
                          if(widget.images.length==currentHouse.images.length){
                            await postDetailsToFirestore();
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Row(
                              children: [
                                SvgPicture.asset("assets/done.svg",color: Colors.white,width: 30,height: 30,),
                                const SizedBox(width: 10,),
                                const Text('Listed succesfully',style: TextStyle(fontWeight: FontWeight.w500),),
                              ],
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                            margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                            )
                          );
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const SplashScreen()));

                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Row(
                              children: [
                                SvgPicture.asset("assets/attention.svg",color: Colors.white,width: 30,height: 30,),
                                const SizedBox(width: 10,),
                                const Text('There is an error',style: TextStyle(fontWeight: FontWeight.w500),),
                              ],
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                            )
                          );

                          }

                          

                        },
                      ),
                    ),
                  )
                ]
              )
            )

        ],
      ),
    );
  }
  Widget incrementBedCount(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Container(
            padding:const EdgeInsets.only(bottom: 15),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade400),
              borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),bottomLeft:  Radius.circular(30))
            ),
            child: const Icon(Icons.minimize ,color: Colors.grey,),
          ),
          onTap: (){
            setState(() {
              if(bedCount>0){
                bedCount--;
              }
              
            });
          },
        ),
        const SizedBox(width: 20,),
        Text("$bedCount",style: const TextStyle(fontWeight: FontWeight.bold ,color: Colors.black54,fontSize: 21),),
        const SizedBox(width: 20,),
        InkWell(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade400),
              borderRadius:const BorderRadius.only(topRight: Radius.circular(30),bottomRight:  Radius.circular(30))
            ),
            child:const Icon(Icons.add ,color: Colors.grey,),
          ),
          onTap: (){
            setState(() {
              bedCount++;
            });
          },
        )
      ],
    
    );
  }
  Widget incrementShowerCount(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Container(
            padding:const EdgeInsets.only(bottom: 15),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade400),
              borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),bottomLeft:  Radius.circular(30))
            ),
            child: const Icon(Icons.minimize ,color: Colors.grey,),
          ),
          onTap: (){
            setState(() {
              if(showerCount>0){
                showerCount--;
              }
              
            });
          },
        ),
        const SizedBox(width: 20,),
        Text("$showerCount",style: const TextStyle(fontWeight: FontWeight.bold ,color: Colors.black54,fontSize: 21),),
        const SizedBox(width: 20,),
        InkWell(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade400),
              borderRadius:const BorderRadius.only(topRight: Radius.circular(30),bottomRight:  Radius.circular(30))
            ),
            child: const Icon(Icons.add ,color: Colors.grey,),
          ),
          onTap: (){
            setState(() {
              showerCount++;
            });
          },
        )
      ],
    
    );
  }
  postDetailsToFirestore()async{
    CollectionReference allhouses =FirebaseFirestore.instance.collection('allHouses');
    String postId =const Uuid().v1();
    currentHouse.postID=postId;
    await allhouses
    .doc(postId)
    .set(currentHouse.toMap());
  }
  Widget incrementKitchenCount(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Container(
            padding:const EdgeInsets.only(bottom: 15),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade400),
              borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),bottomLeft:  Radius.circular(30))
            ),
            child: const Icon(Icons.minimize ,color: Colors.grey,),
          ),
          onTap: (){
            setState(() {
              if(kitchenCount>0){
                kitchenCount--;
              }
              
            });
          },
        ),
        const SizedBox(width: 20,),
        Text("$kitchenCount",style: const TextStyle(fontWeight: FontWeight.bold ,color: Colors.black54,fontSize: 21),),
        const SizedBox(width: 20,),
        InkWell(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade400),
              borderRadius:const BorderRadius.only(topRight: Radius.circular(30),bottomRight:  Radius.circular(30))
            ),
            child: const Icon(Icons.add ,color: Colors.grey,),
          ),
          onTap: (){
            setState(() {
              kitchenCount++;
            });
          },
        )
      ],
    
    );
  }
  Widget incrementFloorsCount(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Container(
            padding:const EdgeInsets.only(bottom: 15),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade400),
              borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),bottomLeft:  Radius.circular(30))
            ),
            child: const Icon(Icons.minimize ,color: Colors.grey,),
          ),
          onTap: (){
            setState(() {
              if(floorCount>0){
                floorCount--;
              }
              
            });
          },
        ),
        const SizedBox(width: 20,),
        Text("$floorCount",style: const TextStyle(fontWeight: FontWeight.bold ,color: Colors.black54,fontSize: 21),),
        const SizedBox(width: 20,),
        InkWell(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade400),
              borderRadius:const BorderRadius.only(topRight: Radius.circular(30),bottomRight:  Radius.circular(30))
            ),
            child:const  Icon(Icons.add ,color: Colors.grey,),
          ),
          onTap: (){
            setState(() {
              floorCount++;
            });
          },
        )
      ],
    
    );
  }

  Widget equipementItems(String label,String icon, bool isSelected,int index){
    return Container(
      padding: const EdgeInsets.symmetric(vertical:4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border:Border.all(color:isSelected? Colors.deepPurpleAccent.shade700:Colors.grey.shade400) ,
        borderRadius: BorderRadius.circular(5)
      ),  
      child:InkWell(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Center(child: SvgPicture.asset(icon,height: 30,width: 30,))),
            Expanded(child: Center(child: Text(label,style: const TextStyle(fontWeight: FontWeight.bold),))),
            Expanded(child: 
            isSelected? const Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.deepPurple,
             
            )
            : Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.grey.shade400,
             
            )
            )
          ],
        ),
        onTap: (){  
          setState(() {
          equipements[index].isSelected=!equipements[index].isSelected; 
          });
          
          if(equipements[index].isSelected == true){
            selectedItems.add(equipements[index].label);

          }else{
            selectedItems.remove(equipements[index].label);

          }

        },
      ),
    );
  }
}