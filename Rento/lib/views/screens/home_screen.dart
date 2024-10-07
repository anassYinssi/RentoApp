import 'package:fluttertoast/fluttertoast.dart';
import 'package:rento/shared/constants.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rento/views/screens/page_navigation_login.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  int pageIdx=0;
  var email1;
  


  @override
  void initState(){
    super.initState();
    getEmail();
    pageIdx=0;
  }
  @override
  void dispose(){
    super.dispose();
    
  }
  

 
  DateTime timeBackPressed =DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        if(pageIdx==0){
        final diferrence =DateTime.now().difference(timeBackPressed);
        final isExitWarnning = diferrence>=const Duration(seconds: 2);

        timeBackPressed=DateTime.now();
        if(isExitWarnning){
          const message ="Press back again to exit";
          Fluttertoast.showToast(msg: message);
          return false;

        }else{
          Fluttertoast.cancel();
          return true;
        }
        }
        setState(() {
          pageIdx=0;
        });
        return false;
        
        
      },
      child: Scaffold(
          body:PageTransitionSwitcher(
            duration: const Duration(milliseconds:600 ),
            transitionBuilder: (child,animation,secondaryAnimation)=>
            FadeThroughTransition(animation: animation, secondaryAnimation: secondaryAnimation,child: child,),
            child: (pageIdx==3||pageIdx==4||pageIdx==2) && (email1==null)? PageNavigationLogin() :pages[pageIdx],
            
            ),
      
          bottomNavigationBar:pageIdx==2?null: BottomNavigationBar(
            onTap: (idx){
              setState(() {
                pageIdx=idx;
              });
            },
            currentIndex: pageIdx,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor:const Color(0XFF042037),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle:const TextStyle(fontWeight: FontWeight.w500) ,
            items: [
              BottomNavigationBarItem(icon:SvgPicture.asset( "assets/homeOutlined.svg",height: 24,width: 24,color: pageIdx==0?Colors.deepPurple:const Color(0XFF042037),),label: "Home"),
              BottomNavigationBarItem(icon:SvgPicture.asset("assets/searchFilled.svg",height: 24,width: 24,color: pageIdx==1?Colors.deepPurple:const Color(0XFF042037)),label: "Search"),
              BottomNavigationBarItem(icon:SvgPicture.asset(pageIdx==2?"assets/addFilled.svg":"assets/addOutlined.svg",height: 24,width: 24,color: pageIdx==2?Colors.deepPurple:const Color(0XFF042037)),label:""),
              BottomNavigationBarItem(icon:SvgPicture.asset(pageIdx==3?"assets/heart0.svg":"assets/heartOutlined.svg",height: 24,width: 24,color: pageIdx==3?Colors.deepPurple:const Color(0XFF042037)),label: "Favorite"),
              BottomNavigationBarItem(icon:SvgPicture.asset(pageIdx==4? "assets/propertyFilled.svg":"assets/propertyOutlined.svg",height: 24,width: 24,color: pageIdx==4?Colors.deepPurple:const Color(0XFF042037)),label: "Ownerships"),
      
            ],
          )
        ));
    
  }
  void getEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var email=preferences.get("email");
    setState(() {
      email1=email;
    });


  }
}