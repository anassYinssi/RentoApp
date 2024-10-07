
import 'package:flutter/material.dart';
class CustomPageRoute extends PageRouteBuilder{
  final Widget child;
  CustomPageRoute({
    required this.child,
  }) : super(
    transitionDuration:const  Duration(milliseconds: 500),
    reverseTransitionDuration:const  Duration(milliseconds: 400),
    pageBuilder: (context,animation,secondaryAnimation)=>child,
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    animation=CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
    secondaryAnimation=CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeOutBack);
    return  SlideTransition(
      position: Tween<Offset>(begin:const Offset(-1,0),end: Offset.zero ).animate(animation),
      child: child ,
    );
  }

}