import 'dart:async';
import 'package:rento/services/custom_page_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({ Key? key }) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen1> {
  bool isVisible =false;

  /*_SplashScreenState(){
    Timer(const Duration(milliseconds: 2000),(){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Welcome()), (route) => false);
      });
    });
    Timer(const Duration(milliseconds: 10),(() {
      setState(() {
        isVisible=true;
      });
    }));


  }*/
  
  @override 
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.of(context).push(CustomPageRoute(child: const SplashScreen()));
    });
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      decoration:const BoxDecoration(
        gradient: LinearGradient(
          colors:[ Colors.white,Colors.white],
          begin:  FractionalOffset(0.0,0.0),
          end: FractionalOffset(1.0,0.0) ,
          stops: [1.0,0.0]
        )
      ),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 1200), 
        opacity: 1.0,

        child: Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child:Center(
              child: SvgPicture.asset("assets/Fichier6.svg",height: 600,width: 700,),
            
          ),
        ),)
        
      ),
    );
  }
}