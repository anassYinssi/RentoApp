// ignore_for_file: deprecated_member_use

import 'package:rento/shared/constants.dart';
import 'package:rento/views/screens/Auth/login.dart';
import 'package:rento/views/screens/Auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Welcome extends StatelessWidget {
  const Welcome({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
        body:DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/villa.jpg",),fit:BoxFit.fill)
          ),
          child: Builder(
            builder: (context) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*Container(child: Lottie.asset("assets/girl.json"),
                        height: 400,
                        margin:const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade200,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20) ,topRight: Radius.circular(20),bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40) )
                         ),
                        ),*/
                        Text('Discover your',style: GoogleFonts.inter(fontWeight:FontWeight.bold,fontSize:30,color: Colors.black87),),
                        Text("Dream house here",style: GoogleFonts.inter(fontWeight:FontWeight.bold,fontSize: 30,color:Colors.black87),),
                        
                        const SizedBox(height: 50,),
                        Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
        
                          ),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  InkWell(
                                    focusColor: Colors.amber,
                                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder:(context){
                                      return const Registre1();}));
                                    },
                                    child: Container(
                                    height: 60,
                                    width: 150,
                                    decoration:BoxDecoration(
                                      color: dWhite,
                                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child:const Center(child: Text('Register'),) 
                                  
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width:50),
                              InkWell(child:const Text('Sign In'),
                              radius: 50,
                              hoverColor: Colors.amber,
                              onTap: (){
                                Navigator.of(context).push(PageTransition(
                                  child: const LoginPage(),
                                  type: PageTransitionType.rightToLeftWithFade,
                                  duration: const Duration(milliseconds:600 ),
                                  curve: Curves.easeInOut
                                
        
                                ));
                              }
                              )
                            ],
                          ),
                        )
        
                        
                      ],
                    ),
              );
            }
          ),
        ),
        
      
       
         
        
      );
  }
}