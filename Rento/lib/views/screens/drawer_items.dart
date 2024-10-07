import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
class DrawerItems extends StatelessWidget {
  const DrawerItems({ Key? key , this.color,this.icon1, required this.nameSection ,  this.icon,required this.onPressed}) : super(key: key);

  final String nameSection ;
  final String? icon ;
  final Color? color;
  final IconData? icon1 ;
  final Function ()onPressed; 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            icon1!=null? Icon(icon1,size: 27,):
            SvgPicture.asset(icon as String,color:color?? Colors.black,height: 25,width: 25, ),
            const SizedBox(width:30),
            Text(nameSection,style: GoogleFonts.inter(fontSize:20 ,color : Colors.black))
          ],
        ),
        
      ),
    );
  }
}