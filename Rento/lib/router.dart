
import 'package:flutter/material.dart';
import 'package:rento/views/screens/more_details.dart';
import 'package:rento/views/screens/post_house_info.dart';
import 'package:rento/views/screens/take_photos.dart';
import 'package:rento/views/select_equipements.dart';

import 'shared/widgets/error.dart';

Route <dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case MakePost.routeName:
    return MaterialPageRoute(builder: (context)=>const MakePost());

    case HouseInfo.routeName:
    return MaterialPageRoute(builder: (context)=> HouseInfo(images: MakePost.images,));

    case MoreDetails.routeName:
    return MaterialPageRoute(builder: (context)=> MoreDetails(images: MakePost.images, category: HouseInfo.defaultCategory, city: HouseInfo.defaultCity,));

    case SelectEquipements.routeName:
    return MaterialPageRoute(builder: (context)=> SelectEquipements(
      images: MakePost.images, 
      category: HouseInfo.defaultCategory, 
      city: HouseInfo.defaultCity, 
      title: MoreDetails.title.text, 
      about:MoreDetails.about.text , 
      adress: MoreDetails.adress.text, 
      aire:double.parse(MoreDetails.aire.text), 
      priceMonth: double.tryParse(MoreDetails.priceMonth.text),
      priceNight: double.parse(MoreDetails.priceNight.text),
      priceYear: double.tryParse(MoreDetails.priceYear.text),));


    default:
    return MaterialPageRoute(builder: (context)=>const ErrorPage());

  }
}