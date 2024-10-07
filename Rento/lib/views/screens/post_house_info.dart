
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rento/services/custom_page_route.dart';
import 'package:rento/shared/widgets/custom_button.dart';
import 'package:rento/views/screens/more_details.dart';

import '../../shared/delay.dart';
class HouseInfo extends StatefulWidget {
  static const routeName ='/houseInfo -screen';
  List<File>images =[];
  static String defaultCategory ='Villa';
  static String defaultCity="Other";



  HouseInfo({Key? key,required this.images}) : super(key: key);

  @override
  State<HouseInfo> createState() => _HouseInfoState();
}

class _HouseInfoState extends State<HouseInfo> {
  List categoryItem =["Villa","simple house","apparetement","Cafe"];
  List cityItems =["Other","Rabat" ,"Ouarzazate","Salé","Safi","Témara","Meknès", "Ben Slimane","Errachidia","Kénitra","Efrane","Khémisset",
    "Khénifra","Sidi Kacem","Oujda","Casablanca","Figuig","Mohammédia" ,"Nador","Azilal","Laâyoune","Béni mellal","Boujdour","El jadida", "Es Semara",
    "Khouribga","Dakhla","Settat", "Agadir","Fès","Guelmim", "Sefrou" ,"Tan Tan","Al Hoceima", "Taroudannt","Boulemane","Tata","Taounate","Tiznit" ,"Taza",
    "Tanger","Marrakech","Chefchaouen","Chichaoua","Larache","Al kelaa des Sraghna", "Tétouan","Essaouirra", ];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  color: Colors.deepPurple,
                  height: 10,
                  width: 2*MediaQuery.of(context).size.width/7,
                        
                ),
              ),
            ),
          Expanded(
            flex: 2,
            child: Container(
                color: Colors.grey.shade100,
                child:const Center(
                  child: Text('Help users to find your propretie easly',
                  style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  
                  ),
                ),
              )
          ),
         
          Expanded(
            flex: 7,
            child: Column(
              children: [
                Expanded(
                  child:Column(
                    children: [
                      const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Choose city',
                          style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200)
                          ),
                          width: 300,
                          height: 10,
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/city.svg", height: 25,width: 25,),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: DropdownButton(
                                  elevation: 5,
                                  underline: const SizedBox.shrink(),
                                  isExpanded: true,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  items: cityItems.map((itemName) {
                                    return DropdownMenuItem(
                                      value: itemName,
                                      child: Text(itemName)
                                    );
                                  }).toList(),
                                  onChanged: (value){
                                    setState(() {
                                      HouseInfo.defaultCity=value as String ;
                                    });
                                  },
                                  value: HouseInfo.defaultCity,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:Column(
                    children: [
                      const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Choose category',
                          style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200)
                          ),
                          width: 300,
                          height: 10,
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/category.svg", height: 25,width: 25,),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: DropdownButton(
                                  elevation: 5,
                                  underline: const SizedBox.shrink(),
                                  isExpanded: true,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  items: categoryItem.map((itemName) {
                                    return DropdownMenuItem(
                                      value: itemName,
                                      child: Text(itemName)
                                    );
                                  }).toList(),
                                  onChanged: (value){
                                    setState(() {
                                      HouseInfo.defaultCategory=value as String ;
                                    });
                                  },
                                  value: HouseInfo.defaultCategory,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:Container(
                    //color: Colors.white,
                  ),
                ),
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
                        text:'BACK',
                        onPressed: ()async{
                          await delay(200);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
    
                  ),
                  Expanded(
                    child:Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 60,
                      child: CustomButton(
                        text: 'NEXT',
                        onPressed: ()async{
                          await delay(400);
                          Navigator.of(context).pushNamed(MoreDetails.routeName);
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
}