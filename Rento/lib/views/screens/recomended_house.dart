// ignore_for_file: non_constant_identifier_names


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:page_animation_transition/animations/left_to_right_faded_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/animations/scale_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:rento/model/house_model.dart';
import 'package:rento/model/user_model.dart';
import 'package:rento/model/services.dart';
import 'package:rento/services/Firestore_helper.dart';
import 'package:rento/services/custom_page_route.dart';
import 'package:rento/shared/constants.dart';
import 'package:rento/views/screens/chat.dart';
import 'package:rento/views/screens/drawer_navigation.dart';
import 'package:rento/views/screens/like_annimation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/delay.dart';
import 'details.dart';



class RecommendedHouse extends StatefulWidget {
   const RecommendedHouse({Key? key}) : super(key: key);


  @override
  State<RecommendedHouse> createState() => _RecommendedHouseState();
}
class _RecommendedHouseState extends State<RecommendedHouse> with SingleTickerProviderStateMixin {
  bool isLiked =false;
  UserModel selectedUser =UserModel(email: '', username: '', tel: '');
  User?currentuser =FirebaseAuth.instance.currentUser;
  CollectionReference usercol= FirebaseFirestore.instance.collection('users');
  bool istapped=false;
  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection('users')
    .doc(currentuser!.uid)
    .get()
    .then((value) {
      selectedUser =UserModel.fromMap(value.data());
      setState(() {
        
      });
    });

  }
  @override
  void dispose(){
    super.dispose();
  }
  
  static final custumCacheManager =CacheManager(
    Config(
      'customCacheManager',
      maxNrOfCacheObjects: 100,

    )
  );


  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child: StreamBuilder<List<Housemodel>>(
                  stream: FirestoreHelper.read(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return  Center(
                        child:CircularProgressIndicator(color: clear,)
                      );
                    }  
                    if(snapshot.hasError){
                      throw snapshot.error!;
                    } 
                    if(snapshot.hasData){
                    final userData = snapshot.data;
                    return 
                    Material(
                      child: CustomScrollView(
                        slivers: [
                           SliverAppBar(
                            shadowColor: Colors.grey.shade400,
                            elevation: 3,
                            actions:[
                              Padding(
                                padding:const EdgeInsets.only(right:20.0),
                                child:GestureDetector( child: SvgPicture.asset('assets/messageOutlined.svg',height:30 ,width: 30,),
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Chat()));
                                },
                                )
                              )
                            ],
                            titleTextStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
                            title:const Text('Rento'),
                            centerTitle: true,
                            automaticallyImplyLeading: false,
                            floating: true,
                            snap: true,
                            backgroundColor: Colors.white,
                            leading: Padding(
                              padding:const EdgeInsets.only(left:20.0),
                              child: GestureDetector(
                                child:selectedUser.image !=null? CircleAvatar(
                                  backgroundImage:CachedNetworkImageProvider( selectedUser.image.toString() ,errorListener: () =>const CircularProgressIndicator(),),
                                )
                                :const CircleAvatar(
                                  backgroundImage: AssetImage('assets/111.png'),
                                ),
                                onTap:(){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NavigationDrawer(
                                  nameUser: selectedUser.username,
                                  image: selectedUser.image,
                                  email: selectedUser.email,
                          
                                )));},
                              ),
                            ),
                            leadingWidth: 45,
                          
                          ),        
                          SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context,index){
                                      final user= userData![index]; 
                                       return Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 8),
                                         child: SizedBox(
                                           height: 210,
                                           child: Card(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            child: InkWell(
                                              //splashColor: Colors.white,
                                              hoverColor:Colors.white ,
                                             onTap:()async{
                                             await delay(200);
                                                Navigator.of(context).push(
                                                  CustomPageRoute(
                                                  
                                                    child:DetailsPage(
                                                      ownerImage:user.profileImage  ,
                                                      ownerName:user.nameProper,
                                                      postTitle:user.name ,
                                                      type:user.type  ,
                                                      ville :user.ville  ,
                                                      images:user.images ,
                                                      priceNight:user.priceNight ,
                                                      priceMonth:user.priceMonth ,
                                                      priceYear:user.priceYear ,
                                                      aire:user.aire ,
                                                      about:user.about ,
                                                      adress:user.adress,
                                                      bedroom:user.bedroom ,
                                                      shower:user.shower,
                                                      kitchen:user.kitchen,
                                                      timePub:user.timePub,
                                                      floor:user.floor,
                                                      equipement:user.equipement,
                                                      userID: user.userID,
                                                      etat:user.etat,
                                                      likes: user.likes,
                                                      postID:user.postID ,
                                                    ),
                                                  )
                                              ) ;} ,
                                              child: Row(
                                              children: [
                                                Stack(
                                                  children: [
                                                     ClipRRect(
                                                       borderRadius:const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:Radius.circular(10) ),
                                                       child: SizedBox(
                                                         width: 150,
                                                         height: MediaQuery.of(context).size.height,
                                                         child:CachedNetworkImage(
                                                          cacheManager: custumCacheManager,
                                                          fit: BoxFit.cover,
                                                          imageUrl: user.images.first,
                                                          placeholder: (context,url)=>Container(
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                
                                                                colors: [Colors.grey.shade200,Colors.grey.shade100,]
                                                              ),
                                                              borderRadius:const BorderRadius.only(bottomLeft:Radius.circular(10),
                                                             ), color: Colors.grey.shade200,
                                                            )
                                                          ),
                                                         )
                                                       ),
                                                     ),
                                                     Positioned(
                                                       top: 5,
                                                       left: 115,
                                                       child: Container(
                                                         padding: const EdgeInsets.all(2) ,
                                                         decoration:BoxDecoration(
                                                           color: Colors.black.withOpacity(0.4),
                                                           borderRadius:const BorderRadius.all(Radius.circular(5)),                                                           
                                                         ),
                                                         child: Row(
                                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                           children: [
                                                             const Icon(Icons.camera_alt_rounded,color:Colors.white,size:20),
                                                             Text('${user.images.length}',style:const TextStyle(color: Colors.white),)
                                                           ],
                                                         ),
                                                       ),
                                                     )
                                                                                             
                                                   ],
                                                 ),
                                                 Expanded(
                                                   flex: 2,
                                                   child: Stack(
                                                     children: [
                                                       Padding(
                                                         padding: const EdgeInsets.all(8.0),
                                                         child: Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             Text(user.name,style: GoogleFonts.inter(fontWeight: FontWeight.w500,fontSize: 20),overflow: TextOverflow.ellipsis,),
                                                             const SizedBox(height: 10,),
                                                             Text('\$ ${user.priceNight}',style: GoogleFonts.varelaRound(color: clear,fontWeight: FontWeight.bold)),
                                                             const SizedBox(height: 20,),
                                                             Row(
                                                               children: [
                                                                 SvgPicture.asset('assets/geo.svg',width:15 ,height: 15,),
                                                                 const SizedBox(width: 8,),
                                                                 Text(user.adress,style: GoogleFonts.inter(color: Colors.grey.shade500,fontWeight: FontWeight.w400,fontSize: 16),),
                                                               ],
                                                             ),
                                                             const SizedBox(height: 10,),
                                                             Row(
                                                               children: [
                                                                 SvgPicture.asset('assets/layers.svg',width:15 ,height: 15,),
                                                                 const SizedBox(width: 8,),
                                                                 Text('${user.aire} sqfm',style: GoogleFonts.inter(color: Colors.grey.shade500,fontWeight: FontWeight.w400,fontSize: 16),),
                                                               ],
                                                             ),
                                                             const SizedBox(height: 10,),
                                                             Row(
                                                               children: [
                                                                 SvgPicture.asset('assets/city.svg',width:15 ,height: 15,),
                                                                 const SizedBox(width: 8,),
                                                                 Text(user.ville,style: GoogleFonts.inter(color: Colors.grey.shade500,fontWeight: FontWeight.w400,fontSize: 16),),
                                                               ],
                                                             ),
                                                             const SizedBox(height: 23,),
                                                             Row(
                                                               children: [
                                                                 SvgPicture.asset('assets/time.svg',width:15 ,height: 15,),
                                                                 const SizedBox(width: 8,),
                                                                 Text(DateFormat.yMMMd().format(user.timePub!.toDate()),style: GoogleFonts.inter(color: Colors.grey.shade500,fontWeight: FontWeight.w400,fontSize: 16),),
                                                               ],
                                                             ),
                                                             
                                                           ],
                                                         
                                                         ),
                                                       ),
                                                       Positioned(
                                                         top: 155,
                                                         left: 180,
                                                         child:LikeAnimation(
                                                             smallike: true,
                                                             isAnimating: user.likes.contains(currentuser!.uid),
                                                             child: IconButton(
                                                               icon :const Icon(Icons.favorite_outline_rounded),
                                                               color:user.likes.contains(currentuser!.uid)?Colors.redAccent:Colors.grey.shade500,
                                                               onPressed: ()async{
                                                                 await Service().likePost(user.postID ,currentuser!.uid, user.likes); 
                                                               },
                                                               
                                                             ),
                                                           ),
                                                       ),
                                                    
                                                     ],
                                                   ),
                                                 )
                                              ],
                                               
                                              ),
                                            ),
                                           ),
                                         ),
                                       );
                                    },
                                    childCount: userData!.length
                                  
                                  ,
                                
                          ),
                        ),
                                        
                        ],
                      
                      ),
                    );
                    }
                
                    return const Center(child: CircularProgressIndicator( ),) ;  
                  
               
                  } ,
                
               
              ),
    );
  
          
     
    
  }
  void Like(){
    setState(() {
      isLiked=!isLiked;
    });
   
  }
}

