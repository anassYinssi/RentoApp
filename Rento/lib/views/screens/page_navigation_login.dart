

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rento/views/screens/Auth/login.dart';
class PageNavigationLogin extends StatelessWidget {
  PageNavigationLogin({Key? key}) : super(key: key);

  final styleButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.deepPurpleAccent,
    minimumSize:const Size(200,60),
    textStyle:const TextStyle(


    ),

  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/loginProcess.svg",height: 200,),
            const SizedBox(height: 30,),
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              child: Text(
                "To have access to more features you should LogIn or Register if you don't have an account. "
                "About this section : Ownerships are the propreties that you've posted, it's allows you to manage them , activate posts, modify informations..."
                ,style: GoogleFonts.salsa(color: Colors.deepPurple,fontSize: 20),textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              style: styleButton,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
              }, 
              child:const Text("Login"),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              style: styleButton,
              onPressed: (){},
              child:const Text("SingUp")
            ),
          ],
        ),
      ),
    );
  }
}