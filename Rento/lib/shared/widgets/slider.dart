// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rento/shared/constants.dart';


class SliderContainer extends StatefulWidget {
  const SliderContainer({ Key? key }) : super(key: key);

  @override
  State<SliderContainer> createState() => _SliderContainerState();
}

class _SliderContainerState extends State<SliderContainer> {

  static double lower_value = 2.0;
  static double upper_value = 10.0;
  
  RangeValues values=RangeValues(lower_value,upper_value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$ '+values.start.toString()+' - \$ '+values.end.toString(),
            style: GoogleFonts.varelaRound(fontSize:19,fontWeight: FontWeight.bold,color: clear),),
            Text('Per month',style: GoogleFonts.varelaRound(fontSize:19,fontWeight: FontWeight.bold),)
          ],
        ),
        const SizedBox(height: 20,),
        RangeSlider(
          min: lower_value,
          max: upper_value,
          values: values,
          divisions: 5,
          labels: RangeLabels(values.start.toString(),values.end.toString()),
          activeColor: clear,
          onChanged: (val){
            setState(() {
              values=val;
            });
          },
          
        ),
      ],
    );
  }
}