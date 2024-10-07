// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:rento/model/house_model.dart';
import 'package:rento/model/services.dart';
import 'package:rento/services/Firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class LikePage extends StatefulWidget {
  const LikePage({ Key? key }) : super(key: key);

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  User?user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Housemodel>> (
          stream: FirestoreHelper.readLikes(),
          builder:(context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent,));
            }
            if(snapshot.hasError){
              throw snapshot.error!;
            }
            if(snapshot.hasData){
              final houseData=snapshot.data;
              return ListView.builder(
              itemCount: houseData!.length,
              itemBuilder: (ctx ,int index){ 
                final house =houseData[index];
                return Column(
                  children: [
                    const Divider(),
                    ListTile(
                      subtitle: Text('In ${house.adress}',style: GoogleFonts.ibmPlexSans(fontSize:12),),
                      leading: GestureDetector(
                       /* onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsPage(
                            name: name,
                            type: type,
                            ville: ville,
                            images: images,
                            price: price,
                            aire: aire,
                            about: about,
                            adress: adress,
                            beedroms: beedroms,
                            bathrooms: bathrooms,
                            kitchens: kitchens,
                            parkings: parkings,
                            likes: likes,
                            PostID: PostID,
                            )));
                        },*/
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: ClipRRect(
                            borderRadius:const BorderRadius.all(Radius.circular(8)),
                            child: CachedNetworkImage(
                              imageUrl:house.images.first,
                              fit: BoxFit.cover,
                              placeholder: (context,url)=>Container(color: Colors.black12,),
                          
                            ),
                            
                          ),
                        ),
                      ),
                      title: Text(house.name,style: GoogleFonts.bebasNeue(fontSize: 20) ),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite_rounded,color: Colors.red,),
                        onPressed: (){
                          Service().likePost(house.postID, user!.uid, house.likes);

                         })
                    ),
                  ],
                );
        
              },
        
              );

            }
            return const Center(
            child: Text('No Favorites ',
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
           
           ),
         );
  });
        
    
  }
}

