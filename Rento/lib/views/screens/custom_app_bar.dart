

// ignore_for_file: deprecated_member_use

import 'package:rento/shared/constants.dart';
import 'package:rento/views/screens/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// ignore: camel_case_types, must_be_immutable
class customAppBar extends StatelessWidget implements PreferredSizeWidget{
  String ?nameUser ;
  String ?image;
  String ?email;
  customAppBar({ Key? key,
  required this.nameUser,
  required this.image,
  required this.email,
  
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon:const Icon(Icons.menu_rounded),),
            Text('RENTO',
            style: GoogleFonts.fredokaOne(
              fontSize:20
            ),),
            InkWell(
              child:
              image!=null?
              CircleAvatar(
              backgroundColor:dBlack,
              maxRadius: 21,
              child: CircleAvatar(
                maxRadius: 20,
                backgroundImage: NetworkImage('$image'),
              ),
              )
              :
              CircleAvatar(
              backgroundColor:dBlack,
              maxRadius: 21,
              child: const CircleAvatar(
                maxRadius: 20,
                backgroundImage: AssetImage('assets/111.png'),
              ),
              )
              ,
              onTap:(){
                 Navigator.of(context).push(MaterialPageRoute(builder:(context){
              return const UpdateProfile();
            }));
              }
            )
    
        ],
      ),
    );

      
    
  }

  @override
  Size get preferredSize =>const Size.fromHeight(50);
 
}
