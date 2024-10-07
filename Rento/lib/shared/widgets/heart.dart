
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class Heart extends StatefulWidget {
  Widget child;
   Heart({ Key? key ,required this.child}) : super(key: key);

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {

  late AnimationController _controller ;
  late Animation _colorAnimation;
  @override
    void initState(){
      super.initState();

      _controller=AnimationController(
        duration: const Duration(microseconds: 200),
        vsync: this
      );

      _colorAnimation=ColorTween(begin: Colors.grey.shade400,end: Colors.redAccent).animate(_controller);



    }





  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder:(BuildContext context,_){
       return widget.child;
      }
    );
  }
}