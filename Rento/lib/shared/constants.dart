import 'package:flutter/material.dart';
import '../model/equipement_model.dart';
import '../views/screens/like.dart';
import '../views/screens/search.dart';
import '../views/screens/home.dart';
import '../views/screens/my_houses.dart';
import '../views/screens/take_photos.dart';

const pages=[
  HomePage(),
  MySearch(),
  MakePost(),
  LikePage(),
  HouseList(),
];
/* House equipements*/
List<Equipement> equipements =[
  Equipement(icon: 'assets/clima.svg', label: 'Clima', isSelected: false),
  Equipement(icon: 'assets/parking1.svg', label: 'Park', isSelected: false),
  Equipement(icon: 'assets/cameraSurveil.svg', label: 'Camera', isSelected: false),
  Equipement(icon: 'assets/2faces.svg', label: 'Faces', isSelected: false),
  Equipement(icon: 'assets/alarm.svg', label: 'Alarm', isSelected: false),
  Equipement(icon: 'assets/light.svg', label: 'Intelligent LS', isSelected: false),
  Equipement(icon: 'assets/remoteControl.svg', label: 'Remote Control', isSelected: false),
  Equipement(icon: 'assets/wifi.svg', label: 'Wifi', isSelected: false),

];

Color b2 = const Color(0x002c0aa6);
Color p1 =const Color(0x006907f2);
Color  p2 =const Color(0x009904d9);
//-------------------------------------------------------
Color primaryColor = const Color(0xFFb71c1c);
Color primaryColorLight = const Color(0xFFf05545);
Color primaryColorDark = const Color(0xFF7f0000);

Color secondaryColor =const Color(0xFFb2dfdb);
Color secondaryColorLight = const Color(0xFFe5ffff);
Color secondaryColorDark = const Color(0xFF82ada9);

Color background = const Color(0xFFfffdf7);
Color textColor = const Color(0xFFffffff);
//----------------------------------------------------------
Color superDark = const Color(0xFF370037);
Color dark = const Color(0xFF530E53);
Color clear = const Color(0xFF8A458A);
Color superClear = const Color(0xFFA66FA6);

//----------------------------------------------------------
Color dWhite =Colors.white;
Color dBlack =Colors.black;
Color black = const Color(0XFF272D2D);
Color alice = const Color(0XFFEDF5FC);
Color violet = const Color(0XFFA39BA8);
Color lightBlue = const Color(0XFFB8C5D6);
Color emerald = const Color(0XFF23CE6B);








