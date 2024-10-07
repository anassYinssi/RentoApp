import 'package:rento/views/screens/recomended_house.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar:customAppBar(),
      body: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
          /* Container(
              padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 15),
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(''),
                 SizedBox(height: 15),
                 Text('Find your sweet home',style: 
                 GoogleFonts.oswald(fontSize:20,fontWeight: FontWeight.bold ),)
          
                ],
              ),
      
            ),*/
            //SearchBar(),
            //categories(),
             const RecommendedHouse(),
            //BestOffer(),
            
          ],
  
        ) 
      ,
 
       //bottomNavigationBar: navigationBar()
      
      
    );
  }
}
