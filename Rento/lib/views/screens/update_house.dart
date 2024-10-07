// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rento/shared/constants.dart';

import '../../shared/loding.dart';

class UpdateHouse extends StatefulWidget {
  const UpdateHouse({ Key? key }) : super(key: key);

  @override
  State<UpdateHouse> createState() => _UpdateHouseState();
}

class _UpdateHouseState extends State<UpdateHouse> {
  final TextEditingController title = TextEditingController();
  final TextEditingController _aire = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _adress = TextEditingController();
  final TextEditingController _about = TextEditingController();
  final TextEditingController _beedroom = TextEditingController();
  final TextEditingController _bathroom = TextEditingController();
  final TextEditingController _kitchen = TextEditingController();
  final TextEditingController _parking = TextEditingController();
  final TextEditingController _ville = TextEditingController();
  final TextEditingController _type = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder (
                stream: FirebaseFirestore.instance.collection('allHouses').where('UserID',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder:(_,AsyncSnapshot <QuerySnapshot<Map<String,dynamic>>> snapshot){
                  if(snapshot.hasData && snapshot.data!= null){
                    if(snapshot.data!.docs.isNotEmpty){
                    return Expanded(
                      child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx ,int index){ 
                        Map<String,dynamic> docata =snapshot.data!.docs[index].data();
                        if(docata.isEmpty){
                          return const Text('Documment not availbale',
                          textAlign: TextAlign.center,
                          
                          );
                        }
                          String name = snapshot.data!.docs.elementAt(index).get("name");
                          List<String> images = snapshot.data!.docs.elementAt(index).get("images").map<String>((i)=> i as String).toList() ;
                          String price = snapshot.data!.docs.elementAt(index).get("price");
                          String aire = snapshot.data!.docs.elementAt(index).get("aire");
                          String about = snapshot.data!.docs.elementAt(index).get("about");
                          String adress = snapshot.data!.docs.elementAt(index).get("adress");
                          String beedroms = snapshot.data!.docs.elementAt(index).get("beedroms");
                          String bathrooms = snapshot.data!.docs.elementAt(index).get("bathrooms");
                          String kitchens = snapshot.data!.docs.elementAt(index).get("kitchens");
                          String parkings = snapshot.data!.docs.elementAt(index).get("parkings");
                          String ville = snapshot.data!.docs.elementAt(index).get("ville");
                          String type = snapshot.data!.docs.elementAt(index).get("Type");
                          
                        return Container(
                          margin:const  EdgeInsets.all(10),
                          height: 300,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius:const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(image: NetworkImage(images.first),fit: BoxFit.cover)
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 322,
                                child: Container(
                                  decoration: const BoxDecoration(color: Colors.black,borderRadius:  BorderRadius.all(Radius.circular(10))),
                                  height: 50,
                                  width: 50,
                                  child: IconButton(
                                   onPressed: (){
                                    title.text=name;
                                        _aire.text=aire;
                                        _adress.text=adress;
                                        _about.text=about;
                                        _ville.text=ville;
                                        _type.text=type;
                                        _beedroom.text=beedroms;
                                        _bathroom.text=bathrooms;
                                        _kitchen.text=kitchens;
                                        _parking.text=parkings;
                                        _price.text=price;
                    
                                      showModalBottomSheet(context: context, builder: (context)=>Dialog(
                                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView(
                                            children: [
                                               Stack(
                                                children:[
                                                  Container(
                                                    height: 40,
                                                    decoration:
                                                      BoxDecoration(
                                                      color: clear,
                                        
                                                       borderRadius:const  BorderRadius.all(Radius.circular(20)) 
                                                    ),
                    
                                                  ),
                                                  Positioned(
                                                    left:90,
                                                    top: 10,
                                                    child:const Text('Quick Modification',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                                ],
                                              ),
                                              const SizedBox(height: 20,),
                                               _TextField( controller: title, label: 'Title', hint: 'Title of the house',padding: 16,),
                                              const SizedBox(height:10),
                                               _TextField(controller: _adress, label: 'Location', hint: 'House adress',padding : 16),
                                              const SizedBox(height:10),
                                               _TextField(padding : 16 ,controller:_ville, label: 'City', hint: 'Enter the city',),
                                              const SizedBox(height:10),
                                               _TextField(padding : 16 ,controller: _type, label: 'Type', hint: 'Type of the house',),
                                              const SizedBox(height:10),
                                               _TextField(controller: _aire, label: 'Aire', padding : 16,hint: 'Aire with m2',keboardType: const TextInputType.numberWithOptions(decimal: false),),
                                              const SizedBox(height:10),
                                               _TextField(controller: _price,label: 'Price',padding : 16, hint: 'Precise price',keboardType:const TextInputType.numberWithOptions(decimal: false),),  
                                              const SizedBox(height:10),
                                               _TextField(padding : 50,maxLenght: 2, controller: _beedroom, label: 'Bedrooms', hint: 'number of beedroms',keboardType:const TextInputType.numberWithOptions(decimal: false),),  
                                               _TextField(padding : 50,maxLenght: 2,controller: _bathroom, label: 'Bathrooms', hint: 'number of bathroom',keboardType: const TextInputType.numberWithOptions(decimal: false),),
                                               _TextField(padding : 50,maxLenght: 2,controller: _kitchen, label: 'Bedrooms', hint: 'number of kitchens',keboardType:const  TextInputType.numberWithOptions(decimal: false),), 
                                               _TextField(padding : 50, maxLenght: 2,controller: _parking, label: 'Bathrooms', hint: 'number of parkings',keboardType:const TextInputType.numberWithOptions(decimal: false),),  
                                               Container(
                                                  decoration:const BoxDecoration(color:Colors.green ,borderRadius: BorderRadius.all(Radius.circular(20))),
                    
                                                 child: InkWell(
                                                  onTap: (){
                                                    loading(context);
                                                    snapshot.data!.docs[index].reference.update({
                                                      'name':title.text,
                                                      'price':_price.text,
                                                      'aire':_aire.text,
                                                      'about':_about.text,
                                                      'adress':_adress.text,
                                                      'beedroms':_beedroom.text,
                                                      'bathrooms':_bathroom.text,
                                                      'kitchens': kitchens,
                                                      'parkings':parkings,
                                                      'Type':_type.text,
                                                      'ville' :_ville.text
                    
                                                  });
                                                  Fluttertoast.showToast(msg: 'House Updated');
                                                  
                                                  },
                                                  child:const Padding(
                                                    padding:  EdgeInsets.all(16),
                                                    child: Text(
                                                      'Update Home info',
                                                      style:TextStyle(color: Colors.white)
                                                    ),
                                                    
                                                    
                                                  )),
                                               ),
                                               const SizedBox(height: 5,),
                                                Container(
                                                  decoration:const BoxDecoration(color: Colors.red ,borderRadius: BorderRadius.all(Radius.circular(20))),
                                                  child: InkWell(
                                                    //color: Colors.red,
                                                  onTap: (){
                                                    loading(context);
                                                    snapshot.data!.docs[index].reference.delete();
                                                    Fluttertoast.showToast(msg: 'House Deleted');
                                                    Navigator.of(context).pop(); 
                    
                                                    
                                                  },
                                                  child:const Padding(
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                      'Delete Home ',
                                                       style:TextStyle(color: Colors.white)
                                                    ),
                                                    
                                                    
                                                  )),
                                                )
                    
                                            ],
                                          ),
                                        )
                                      ));
                    
                                   }, 
                                   icon:const Center(child:Icon(Icons.edit,color: Colors.white,))),
                                ),
                              ),
                              Positioned(
                                top: 260,
                                child :Container(
                                  padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                                  width: MediaQuery.of(context).size.width-20,
                                  height: 60,
                                  decoration:  BoxDecoration(color: Colors.grey.shade200,borderRadius:const  BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Text(name,style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.place,size: 15,),
                                          const SizedBox(width: 5,),
                                          Text(adress),
                                        ],
                                      )
                                    ],
                                  ),

                                )
                              )
                            ],
                          ),

                        );
                                
                      },
                                
                      ),
                    );
    
                    }
                  }else{
                    return const Center(child:CircularProgressIndicator());
                  }
               return const Center(
                 child: Text('Getting Error'),
               );
                }
                
                
          );

  }
}
class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final int?maxlines;
  final Icon? prefixIcon;
  final Icon ?sufixIcon;
  final String label ;
  final String ?hint;
  final bool ?isPassword ;
  final TextInputType? keboardType;
  final int? maxLenght ;
  final double padding;
  final FormFieldValidator<String>? validator;

   const _TextField({
    required this.padding,
    this.hint,
    this.maxlines,
    required this.controller,
    required this.label,
    this.isPassword,
    this.keboardType, 
    this.validator,
    this.sufixIcon,
    this.prefixIcon,
    this.maxLenght


  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: padding),
      child: TextFormField(
        maxLength: maxLenght,
        controller: controller,
        keyboardType: keboardType,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hint,
          suffixIcon: sufixIcon,
          border:const OutlineInputBorder(),
          label: Text(label),
        ),
        maxLines: maxlines,
        validator: validator,

      ),
    );
    
  }
}