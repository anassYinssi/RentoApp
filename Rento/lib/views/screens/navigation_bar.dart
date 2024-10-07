import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../shared/constants.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({ Key? key }) : super(key: key);

  @override
  State<NavigationBar> createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar> {
  get index1 => null;

  @override
  Widget build(BuildContext context) {
    return Container(
       //color: Colors.purple,
        decoration: BoxDecoration(/*borderRadius: BorderRadius.circular(44),*/color: superDark),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: GNav(
          gap: 8,
         // rippleColor: Colors.red,
         
          color: Colors.white,
          iconSize: 24,
          activeColor: Colors.white,
          backgroundColor:superDark,
          tabBackgroundColor:Colors.white30,
          curve: Curves.easeIn,
          padding: const EdgeInsets.all(8),
          onTabChange: (index){
          },
          tabs:const [
          GButton(icon: Icons.home ,text: 'Home',),
          GButton(icon: Icons.favorite_border ,text: 'Likes',),
          GButton(icon: Icons.search ,text: 'Search',),
          GButton(icon: Icons.notifications ,text: 'Notifications',),


        ])
        ,), 
      
    );
  }
}