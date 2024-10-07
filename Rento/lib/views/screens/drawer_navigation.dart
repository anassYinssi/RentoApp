import 'package:flutter_svg/svg.dart';
import 'package:rento/model/services.dart';
import 'package:rento/shared/constants.dart';
import 'package:rento/views/screens/drawer_items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Auth/login.dart';
// ignore: must_be_immutable
class NavigationDrawer extends StatelessWidget {
  String?nameUser ;
  String?image;
  String?email;
  NavigationDrawer({ Key? key,
  required this.nameUser,
  required this.image,
  required this.email,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width:100 ,
      child: Material(
        color:Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              SafeArea(
                child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    child: SvgPicture.asset('assets/back1.svg',color: Colors.black,width: 30,height: 30,),
                    onTap: (){Navigator.of(context).pop();},
                  ),
                  const SizedBox(width: 120,),
                  const Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),)
                ],
              )
              ),
              const SizedBox(height: 20,),

              Row(
              children: [
                image!=null?
                CircleAvatar(
                  radius: 41,
                  backgroundColor: dWhite,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(image as String), ),
                )
                :CircleAvatar(
                  radius: 41,
                  backgroundColor: dWhite,
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/111.png'), ),
                ),
                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nameUser as String,style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize:14),),
                    const SizedBox(height: 10,),
                    Text(email as String ,style: GoogleFonts.inter(fontSize:14),)
                  ],
                )


                    
              

                ],
              ),
              const SizedBox(height: 30,) ,
              Divider(thickness: 1,color: Colors.grey.shade200, height: 10,),
              const SizedBox(height: 30,) ,
              DrawerItems(
                nameSection: "My Profile",
                icon1: Icons.person_outline_outlined,
                onPressed: ()=>onItempressed(context,index:0)),

              const SizedBox(height: 30,) ,

              DrawerItems(
              
                nameSection: "Settings",
                icon:'assets/settings1.svg',
                onPressed: ()=>onItempressed(context,index:1)),

              const SizedBox(height: 30,) ,

              DrawerItems(
                nameSection: "Notifications",
                icon:'assets/notification.svg',
                onPressed: ()=>onItempressed(context,index:2)),

              const SizedBox(height: 30,) ,

              DrawerItems(
                nameSection: "Analytics",
                icon:'assets/analytics.svg',
                onPressed: ()=>onItempressed(context,index:3)),

              const SizedBox(height: 30,) ,
              Divider(thickness: 1,color: Colors.grey.shade100, height: 10,),
              const SizedBox(height: 30,) ,

              DrawerItems(
                nameSection: "FAQ",
                icon: 'assets/question.svg',
                onPressed: ()=>onItempressed(context,index:4)),

              const SizedBox(height: 30,) , 
              
              DrawerItems(
                nameSection: "About",
                icon:'assets/about.svg',
                onPressed: ()=>onItempressed(context,index:5)),

              const SizedBox(height: 30,) ,
            InkWell(
              borderRadius: BorderRadius.circular(10),
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
                nameUser=null;
                email=null;
                image=null;

              },
              autofocus: true,
            ),
            ],
            
          ),
        ),
        
      ),
    );
  }
  void onItempressed(BuildContext context,{required int index}){
    Navigator.pop(context);
    switch(index){
      //case 0 :
      //Navigator.of(context).push(MaterialPageRoute(builder: ((context) => HouseList())));
      //  break;
      

    }


  }
  Widget widgetHeader(){
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/icons/a5.jpg'), ),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$nameUser',style: GoogleFonts.inter(fontSize:14,color: Colors.white,),),
            const SizedBox(height: 10,),
            Text('loggedInUser.email',style: GoogleFonts.inter(fontSize:14,color: Colors.white,),)
          ],
        )


         
    

      ],
    );

  }

  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
  Future<void> logout(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context)=>const LoginPage())
    );

    

  }
}