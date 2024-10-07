
// ignore_for_file: non_constant_identifier_names

import 'package:rento/shared/constants.dart';
import 'package:rento/views/screens/details.dart';
import 'package:rento/views/screens/filter_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
class MySearch extends StatefulWidget {
  const MySearch({ Key? key }) : super(key: key);

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  TextEditingController searchController =TextEditingController();
  bool isShowPost=false;
  bool isTappedSearch=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 45,
                child: TextField(
                cursorHeight: 25,
                cursorColor: clear,
                cursorWidth: 1.4,  
                controller: searchController,
                decoration: InputDecoration(
                  fillColor: Colors.blueGrey,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.grey,style:BorderStyle.solid)
                  ),
                  focusedBorder:const OutlineInputBorder(
                    borderSide: BorderSide.none
                  ),
                 hintText:'Search',
                 icon:isTappedSearch? IconButton(
                  onPressed: (){
                   FocusScope.of(context).unfocus();
                   searchController.clear();
                   setState(() {
                    isShowPost=false;
                  });
                  isTappedSearch=false;
                  },
                  icon: SvgPicture.asset("assets/back1.svg"),
                 )
                 :const CircleAvatar()
                    
                ) ,
                onTap: (){
                  setState(() {
                    isTappedSearch=true;
                  });
                },
                onSubmitted:(c){
                  setState(() {
                    isShowPost=true;
                  });
                },
                
                    
                ),
              ),
           ),
           const Divider(),

              
          
          isShowPost? Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection('allHouses').where(
                'ville',isEqualTo :searchController.text  ,      
                ).get(),
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(
                  child: CircularProgressIndicator()
                  );
                }
                if(snapshot.hasError){
                    throw snapshot.error!;
                    //return const Center(child: Text("there is some error"),);
                } 
                if(snapshot.hasData){
                return ListView.builder(
                  itemCount: (snapshot.data as dynamic).docs.length,
                  itemBuilder:(context,index){
                    String name = (snapshot.data! as dynamic).docs.elementAt(index).get("name");
                    List<String> images = (snapshot.data! as dynamic).docs.elementAt(index).get("images").map<String>((i)=> i as String).toList() ;
                    List<String> equipement= (snapshot.data! as dynamic).docs.elementAt(index).get("equipement").map<String>((i)=> i as String).toList() ;
                    double priceNight = (snapshot.data! as dynamic).docs.elementAt(index).get("priceNight");
                    double priceMonth = (snapshot.data! as dynamic).docs.elementAt(index).get("priceMonth");
                    double priceYear = (snapshot.data! as dynamic).docs.elementAt(index).get("priceYear");
                    double aire = (snapshot.data! as dynamic).docs.elementAt(index).get("aire");
                    String about = (snapshot.data! as dynamic).docs.elementAt(index).get("about");
                    String adress = (snapshot.data! as dynamic).docs.elementAt(index).get("adress");
                    int bedroom =(snapshot.data! as dynamic).docs.elementAt(index).get("bedroom");
                    int shower =(snapshot.data! as dynamic).docs.elementAt(index).get("shower");
                    int kitchen =(snapshot.data! as dynamic).docs.elementAt(index).get("kitchen");
                    int floor =(snapshot.data! as dynamic).docs.elementAt(index).get("floor");
                    String ville = (snapshot.data! as dynamic).docs.elementAt(index).get("ville");
                    bool state = (snapshot.data! as dynamic).docs.elementAt(index).get("etat");
                    String type = (snapshot.data! as dynamic).docs.elementAt(index).get("Type");
                    String PostID = (snapshot.data! as dynamic).docs.elementAt(index).get("PostID");
                    String userID = (snapshot.data! as dynamic).docs.elementAt(index).get("UserID");
                    List likes = (snapshot.data! as dynamic).docs.elementAt(index).get("likes");
                    return Column(
                      children: [
                        //const Divider(),
                        ListTile(
                            title:Text(name),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_rounded),
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsPage(
                                  postTitle: name,
                                  type: type,
                                  ville: ville,
                                  images: images,
                                  priceNight: priceNight,
                                  priceMonth: priceMonth,
                                  priceYear: priceYear,
                                  aire: aire,
                                  about: about,
                                  adress: adress,
                                  bedroom: bedroom,
                                  shower: shower,
                                  floor: floor,
                                  kitchen: kitchen,
                                  likes: likes,
                                  postID: PostID, 
                                  etat: state, 
                                  ownerName: '',
                                  userID: userID,
                                  equipement: equipement,
                                  
                                  )));
                              },
                            
                            ),
                            subtitle: Text('In $ville',style: GoogleFonts.ibmPlexSans(fontSize:12),),
                            leading: Image.network(images.first,fit: BoxFit.fitWidth,),
                                         
                        ),
                      ],
                    );
                  

                  }
               );}
                return const Center(
                child: Text("No result",style:TextStyle(color:Colors.black))
                );
               
              }
            ),
          ):
          const FilterPage()
        ],
      )

    );
  }
}