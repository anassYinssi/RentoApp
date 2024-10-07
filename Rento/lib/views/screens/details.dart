import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rento/model/user_model.dart';
import 'package:rento/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {

  final String postTitle;
  final List<String>images;
  final double priceNight;
  final double? priceMonth;
  final double? priceYear;
  final double aire;
  final String ownerName;
  final String? ownerImage;
  final String about;
  final String adress;
  final int bedroom;
  final int kitchen;
  final int shower;
  final int floor;
  final String type;
  final String ville;
  final String userID;
  final String postID;
  final bool? etat;
  final List likes;
  final List<String> equipement;
  final Timestamp? timePub;

  const DetailsPage( { Key? key,

  required this.postTitle,
  required this.type,
  required this.ville,
  required this.images,
  required this.priceNight,
  this.priceMonth,
  this.priceYear,
  required this. aire,
  required this. about,
  required this. adress,
  required this. bedroom,
  required this. shower,
  required this. kitchen,
  required this. floor,
  required this. ownerName,
  this. ownerImage,
  required this.userID,
  required this.etat,
  required this.postID,
  required this.likes,
  this.timePub,
  required this.equipement
  
  
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  User?user=FirebaseAuth.instance.currentUser;
  late int selectedIndex=0;
  late UserModel loggedinUser ;
  String priceMonthString='';
  String priceYearString='';
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
    if(widget.priceMonth==null){
      priceMonthString='Price not specified';

    }else{
      priceMonthString='${widget.priceMonth}';
    }
    if(widget.priceMonth==null){
      priceYearString='Price not specified';
    }else{
      priceYearString='${widget.priceYear}';
    }
   
  

  }
  bool forcedIndex=false;
  String priceCategory ='Night';
  final List items=['Night','Month','Year'];
  final equipementsTextStyle=const TextStyle(color:Colors.black38, fontWeight: FontWeight.bold, fontSize: 13);
  bool isExpanded=false;

  TextEditingController nuits =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          //detailsAppBar
           SafeArea(
             child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius:BorderRadius.circular(30),
              ),
              height: 350,
              child: Stack(children: [
                ClipRRect(
                  borderRadius:const BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight:Radius.circular(30)),
                  child:myCarousel()
                ),
                SafeArea(child:
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20),
                  child: GestureDetector(
                     onTap: () {
                       Navigator.of(context).pop();
                     },
                     child: SizedBox(
                       height: 30,
                       width: 30,
                       child:SvgPicture.asset('assets/back1.svg',color: Colors.white,) ,
                     ),
                   ),
                ))
              ]),
              
                     ),
           ),
          //contenu
           Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.images.length>1?
                Container(
                  padding: const EdgeInsets.only(top:9 ),
                  height: 18,
                  child: Center(
                    child: ListView.separated(
                      separatorBuilder: ((context, index) => const SizedBox(width: 5,)),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.images.length,
                      itemBuilder:(context, index) {
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              forcedIndex=true;
                              selectedIndex=index;
                            });
                          },
                          child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:selectedIndex==index? Colors.black:Colors.black.withOpacity(0.3),
                                              
                          ),
                          ),
                        );
                      } 
                    ),
                  ),
                ):const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.postTitle,style: GoogleFonts.varelaRound(fontSize:22,fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        SizedBox(height: 20,width: 20, child: SvgPicture.asset("assets/star1.svg",color: Colors.amber,),),
                        const SizedBox(width: 5,),
                        Text("4.8",style: GoogleFonts.varelaRound(color:Colors.black38, fontSize:20,))
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    widget.etat==false?
                    Row(
                      children: [
                        const Text('State: Available',style: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),),
                        Container(height: 6,width: 6,
                        decoration:const  BoxDecoration(color:Colors.greenAccent ,shape: BoxShape.circle),
                        margin: const EdgeInsets.only(bottom: 7,left: 2),
                        )
                      ],
                    )
                    :
                    Row(
                      children: [
                        const Text('State: Rented',style: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),),
                        Container(height: 6,width: 6,
                        decoration:const  BoxDecoration(color:Colors.redAccent ,shape: BoxShape.circle),
                        margin: const EdgeInsets.only(bottom: 7,left: 2),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
        
                          " \$ ${(priceCategory.compareTo('Night')==0?widget.priceNight:(priceCategory.compareTo('Month')==0?priceMonthString:priceYearString))} / ",
                          style: GoogleFonts.varelaRound(fontSize:16 , fontWeight: FontWeight.bold,color: superClear)
                        ),
                        selectPriceCategory()
                        
                      ]
                    
                    ),

                   ],
                 ),
                const SizedBox(height: 20,),
                
                const Divider(),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Type '),
                    Text(widget.type,style: const TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 10,),
               
                const Divider(),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Adress '),
                    Text(widget.adress,style:const TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                const SizedBox(height: 10,),
                const Divider(),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('City '),
                    Text(widget.ville,style:const TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 10,),
                const Divider(),
          
              ],
            ),
          ),
          //house info Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Equipements'),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Wrap(
                    spacing: 50,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset("assets/bedroom4.svg",height: 40,width: 40,),
                          const SizedBox(height: 5,),
                          Text('${widget.bedroom}',style: const TextStyle(fontWeight: FontWeight.bold),),
                          const SizedBox(height:5),
                          Text("Bedroom",style: equipementsTextStyle,)
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset("assets/toilet.svg",height: 40,width: 40),
                          const SizedBox(height: 5,),
                          Text('${widget.shower}',style: const TextStyle(fontWeight: FontWeight.bold),),
                          const SizedBox(height:5),
                          Text("Shower",style:equipementsTextStyle)
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset("assets/kitchen1.svg",height:40,width:40),
                          const SizedBox(height: 5,),
                          Text('${widget.kitchen}',style: const TextStyle(fontWeight: FontWeight.bold),),
                          const SizedBox(height:5),
                          Text("Kitchen",style:equipementsTextStyle)
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset("assets/park2.svg",height: 40,width: 40),
                          const SizedBox(height: 5,),
                          Text('${widget.floor}',style: const TextStyle(fontWeight: FontWeight.bold),),
                          const SizedBox(height:5),
                          Text("floor",style: equipementsTextStyle)
                        ],
                      ),
                  
                      
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                const Divider(),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Aire'),
                    SvgPicture.asset('assets/sqft.svg',width: 25,height: 25,),
                    Text('${widget.aire}',style: GoogleFonts.publicSans(fontWeight: FontWeight.bold,),),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          const Divider(),
          //Features
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Features'),
                    isExpendedBoutton()
                  ],
                ),
              ),
              AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration:const Duration(milliseconds: 600),
                height: isExpanded?300:0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing: 5,mainAxisSpacing: 5),
                    itemBuilder: (context,index){
                      return equipementFeatures(widget.equipement, index);
                    },
                    itemCount: widget.equipement.length,
         
                  
                  ),
                ),
              ),
            ],
          ),


         
          //About section
          Container(
            
            padding: const EdgeInsets.symmetric(horizontal:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const Text('About',),
                const SizedBox(height: 20,),
                Text(widget.about
                ,style:equipementsTextStyle,)
              ],
            ), 
          ),

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300,width: 1.6),
              borderRadius:const BorderRadius.all(Radius.circular(20))  
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin:const EdgeInsets.symmetric(vertical:20,horizontal: 20),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(height:50,width: 50, child: ClipRRect(borderRadius:const BorderRadius.all(Radius.circular(10)) ,
                     child: widget.ownerImage!=null? Image.network(widget.ownerImage as String,fit: BoxFit.cover,):Image.asset("assets/111.png"))),
                    const SizedBox(width: 15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.ownerName ,style:const TextStyle(color:Colors.black87, fontWeight: FontWeight.w500,fontSize: 18),),
                        const SizedBox(height: 5,),
                        const Text('Owner',style:  TextStyle(color: Colors.black38,fontWeight: FontWeight.w500),)
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(color: black,borderRadius: const BorderRadius.all(Radius.circular(10))),
                  height: 50,
                  width: 50,
                  child: IconButton(onPressed: (){}, icon:const Icon(Icons.comment,color: Colors.white,)),
                )
              ],
            ),
          ),
          //Book now
           const SizedBox(height: 25,),
           Container(
             padding: const EdgeInsets.symmetric(horizontal: 20),
             child:ElevatedButton(
              onPressed: () =>showDialog(context: context, barrierDismissible: false, builder: (context)=>Dialog(
                shape:const  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children:[
                          Container(
                            height: 40,
                            decoration:
                             const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(Radius.circular(20)) 
                            ),

                          ),
                           Positioned(
                            left: 110,
                            top: 10,
                        
                            child: Text('ATTENTION',style: TextStyle(color: dWhite,fontWeight: FontWeight.bold),)),


                        ],
                      ),
                     LottieBuilder.asset('assets/security.json'),
                    const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                      
                     child: Text(
                     'Make sure to never send money in advance to any the seller by bank transfer or an agency of money transferring ',
                     style: TextStyle(color: Colors.grey),
                     
                     )),
                     const SizedBox(height: 20,),
                     Center(child: Text('Contact Now',style: TextStyle(color: dBlack,fontWeight: FontWeight.bold),)),
                     Container(
                      margin: const EdgeInsets.symmetric(vertical:15,horizontal: 20),
                      width: 180,
                      color: Colors.green,
                       child: InkWell(
                       onTap: ()async{
                        launch('tel:${loggedinUser.tel}');
                       }, 
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           Icon(Icons.phone_outlined,color: dWhite,),
                           const SizedBox(width: 5,),
                           Text(
                            '${loggedinUser.tel}',
                            style: TextStyle(color: dWhite,letterSpacing: 4,fontSize: 15),
                           ),
                         ],
                       )),
                    )



                     

                    ],
                  ),
                ),
              ), 
            ),
             style: ElevatedButton.styleFrom(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
               primary: emerald
             ),
             child: Container(
               padding: const EdgeInsets.symmetric(vertical: 15),
               alignment: Alignment.center,
               child: const Text('Book Now'),
             ),)
           )
        
          ],
        ),
      ),
    );
  }
  
  Widget isExpendedBoutton(){
    return Material(
      child: InkWell(
        child: SvgPicture.asset(isExpanded?"assets/arrow-up.svg":"assets/arrow-down.svg",width: 30,height: 30,),
        onTap:(){
          setState(() {
            isExpanded=!isExpanded;
          });
        
        }
      ),  
    );
  }

  Widget myCarousel (){
    return CarouselSlider.builder(
      options: CarouselOptions(
        viewportFraction: 1,
        height: MediaQuery.of(context).size.height,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds:2),
        enableInfiniteScroll: false,
        onPageChanged: ((index, reason) {
          setState(() {
            selectedIndex=index;
          });
        })
      ),
      itemCount: widget.images.length,
      itemBuilder:((context, index, realIndex) {
        return CachedNetworkImage(
        imageUrl:forcedIndex?widget.images.elementAt(selectedIndex):widget.images.elementAt(index),
        fit: BoxFit.cover,
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        placeholder: (context,url)=>Container(
          decoration: BoxDecoration(
            borderRadius:const BorderRadius.only(bottomLeft:Radius.circular(30),
            bottomRight:Radius.circular(30)), color: Colors.grey.shade200,
          )), 
      );
      }
        
    ),      
    );
  }
  Widget selectPriceCategory(){
    return DropdownButton(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      items: items.map((itemName) {
        return DropdownMenuItem(
          value: itemName,
          child: Text(itemName)
        );
      }).toList(),
      onChanged: (value){
        setState(() {
          priceCategory=value as String ;
        });
      },
      value: priceCategory,
      style: GoogleFonts.varelaRound(fontSize:16 ,fontWeight: FontWeight.bold,color: Colors.black38)

    );
  }
  Widget equipementFeatures(List<String> t,int index){
    for(int i=0;i<equipements.length;i++){
      if(t[index]==equipements[i].label){
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey)
          ),
          padding:const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Center(child: SvgPicture.asset(equipements[i].icon,height: 30,width: 30,))),
              Expanded(child: Center(child: Text(equipements[i].label,style: const TextStyle(fontWeight: FontWeight.bold),))),
            ],
          ),
        );
      }
    }
    return const SizedBox.shrink();


  }

}

// ignore: unused_element
class _TextField extends StatelessWidget {
  final TextEditingController ?controller;
  final Icon? prefixIcon;
  final String ?hint ;  
  final TextInputType? keboardType;
  final FormFieldValidator<String>? validator;
  final int? maxlengh;


  const _TextField({
    this.controller,
    this.keboardType, 
    this.validator,
    this.prefixIcon,
    this.maxlengh,
     this.hint

  });
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(20),
      child:TextField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: keboardType,         
        maxLines: maxlengh,       
        controller: controller,
        decoration:InputDecoration(
        filled:true,
        fillColor: superClear.withOpacity(0.1),
        suffixIcon:Icon(Icons.edit,color:dark,) ,       
        enabledBorder: OutlineInputBorder(
        borderSide:BorderSide(color:clear,width: 0.5) 
        )
        ),
              ),
    );
    
  }
}