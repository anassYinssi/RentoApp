import 'dart:io';
import 'package:rento/shared/constants.dart';
import 'package:rento/views/screens/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
 
  File? profileImage;

  Future pickImage( ImageSource source)async{
    try{
    final profileImage =await ImagePicker().pickImage(source: source);
    if(profileImage==null)return; 
    final temporaryImage = File(profileImage.path);
    setState(() => this.profileImage=temporaryImage);
    }on PlatformException catch(e){
     e.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color.fromARGB(206, 48, 48, 48),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            IconButton(icon:const Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              Navigator.of(context).pop();

            },),
            const Icon(Icons.wb_sunny_outlined,color: Colors.white,)
          ],
           
          ),
          const SizedBox(height: 25,),
          Column(
            children: [
                  const CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/a5.jpg'),
                
                  maxRadius: 50,
                ),
              
              const SizedBox(height: 30,),
              Text('loggedInUser.username' ,style: GoogleFonts.inter(color:Colors.white,fontWeight: FontWeight.bold),),
              Text('loggedInUser.email',style: GoogleFonts.inter(color:Colors.grey),),
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const UpdateProfile()));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  height: 50,
                  decoration: BoxDecoration(
                    color: clear,
                    borderRadius: BorderRadius.circular(40)
              
                  ),
                    child: Center(
                      child: Text(
                        'UPDATE PROFILE',
                        style: GoogleFonts.inter(color:Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ),
              
              const SizedBox(height: 25,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 73, 72, 72)

                      ),
                      child: 
                      Row(
                        children: [
                          const SizedBox(width: 10,),
                          const Icon(Icons.person,color: Colors.white,),
                          const SizedBox(width: 15,),
                          Text('Privacy',style: GoogleFonts.alegreyaSans(color:Colors.white,fontSize:20,fontWeight: FontWeight.w500),),
                          const SizedBox(width: 170,),
                          const Icon(Icons.navigate_next_rounded,color: Colors.white,size: 45,)
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 73, 72, 72)

                      ),
                      child: 
                      Row(
                        children: [
                          const SizedBox(width: 10,),
                          const Icon(Icons.history_rounded,color: Colors.white,),
                          const SizedBox(width: 15,),
                          Text('Purshases History',style: GoogleFonts.alegreyaSans(color:Colors.white,fontSize:18,fontWeight: FontWeight.w500),),
                          const SizedBox(width: 105,),
                          const Icon(Icons.navigate_next_rounded,color: Colors.white,size: 45,)
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 73, 72, 72)
                      ),
                      child: 
                      Row(
                        children: [
                          const SizedBox(width: 10,),
                          const Icon(Icons.help_center_rounded,color: Colors.white,),
                          const SizedBox(width: 15,),
                          Text('Help & Support',style: GoogleFonts.alegreyaSans(color:Colors.white,fontSize:20,fontWeight: FontWeight.w500),),
                          const SizedBox(width: 105,),
                          const Icon(Icons.navigate_next_rounded,color: Colors.white,size: 45,)
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 73, 72, 72)

                      ),
                      child: 
                      Row(
                        children: [
                          const SizedBox(width: 10,),
                          const Icon(Icons.settings_outlined,color: Colors.white,),
                          const SizedBox(width: 15,),
                          Text('Settings',style: GoogleFonts.alegreyaSans(color:Colors.white,fontSize:20,fontWeight: FontWeight.w500),),
                          const SizedBox(width: 160,),
                          const Icon(Icons.navigate_next_rounded,color: Colors.white,size: 45,)
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color:const Color.fromARGB(255, 73, 72, 72)

                      ),
                      child: 
                      Row(
                        children: [
                          const SizedBox(width: 10,),
                          const Icon(Icons.people,color: Colors.white,),
                          const SizedBox(width: 15,),
                          Text('Invite Freinds',style: GoogleFonts.alegreyaSans(color:Colors.white,fontSize:20,fontWeight: FontWeight.w500),),
                          const SizedBox(width: 120,),
                          const Icon(Icons.navigate_next_rounded,color: Colors.white,size: 45,)
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color:const Color.fromARGB(255, 73, 72, 72)

                      ),
                      child: 
                      Row(
                        children: [
                          const SizedBox(width: 10,),
                          const Icon(Icons.logout_outlined,color: Colors.white,),
                          const SizedBox(width: 15,),
                          Text('Logout',style: GoogleFonts.alegreyaSans(color:Colors.white,fontSize:20,fontWeight: FontWeight.w500),),
                          const SizedBox(width: 170,),
                          const Icon(Icons.navigate_next_rounded,color: Colors.white,size: 45,)
                        ],
                      ),
                    ),

                  ],
                ),
              )

            ],
          )
        ],),
      )     

      
       
    ); 

  }
  
}
