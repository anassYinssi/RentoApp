
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rento/shared/constants.dart';
import 'package:rento/shared/widgets/slider.dart';
class FilterPage extends StatefulWidget {
  const FilterPage({ Key? key }) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> with SingleTickerProviderStateMixin{
  
  int? _value;
  String? selectedType;
  var items =['Villa','Simple house','Apparetement','Cafe','xxxx','wwww','sssss','rrrrr'];
  int? selectedbed=0;
  int? selectedbath=0;
  int? selectedkitch=0;
  int? selectedpark=0;
  bool more_type=false;
  TextEditingController  min_controller =TextEditingController();
  TextEditingController  max_controller =TextEditingController();


  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
          child: Container(
            padding:const EdgeInsets.symmetric(horizontal:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Type',style: GoogleFonts.varelaRound(fontSize:22,fontWeight: FontWeight.bold),),
                    IconButton(
                    onPressed: (){
                      setState(() {
                      more_type= !more_type;
                    });
                    },
                    icon: SvgPicture.asset(more_type?'assets/arrow-up.svg':'assets/arrow-down.svg',color: clear,width: 30,height: 30,))
                  ],
                ),
                  Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children:List<Widget>.generate(
                        more_type?items.length:4,
                        (int index){
                        return ChoiceChip(
                          labelPadding:const EdgeInsets.symmetric(horizontal:8,vertical: 6),
                          selectedColor: clear,
                          backgroundColor:Colors.grey.shade100,
                          side: BorderSide(color: Colors.grey.shade200),
                          labelStyle: TextStyle(color:selectedType==items[index]? Colors.white:Colors.black,fontSize: 15),
                          label: Text(items[index]), 
                          selected: selectedType==items[index],
                          onSelected: (bool selected){
                            setState(() {

                              selectedType=selected? items[index]:null;
                            });
                          },
                        );}
                      ).toList()
                  ),
                
              
                const SizedBox(height: 20,),
                Divider(endIndent: 30,indent: 30,color: Colors.grey.shade200,thickness: 2,),
                const SizedBox(height: 20,),
                Text('Price',style: GoogleFonts.varelaRound(fontSize:22,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                const SliderContainer(),
                const SizedBox(height: 20,),
                Divider(endIndent: 30,indent: 30,color: Colors.grey.shade200,thickness: 2,),
                const SizedBox(height: 20,),
                Text('Size',style: GoogleFonts.varelaRound(fontSize:22,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Row(
                  children:[
                    Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: min_controller,
                        decoration:InputDecoration (
                          prefixText: "Min",
                          prefixStyle:const TextStyle(fontWeight: FontWeight.bold),
                          fillColor: Colors.amberAccent,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:const BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.grey.shade300,style: BorderStyle.solid),
                          ),
                          focusedBorder: OutlineInputBorder( 
                            borderRadius:const BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.grey.shade300,style: BorderStyle.solid),
                          )
                        ),

                      ),
                    )
                    ,),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: max_controller,
                        decoration:InputDecoration (
                          prefixText: "Max",
                          suffixText: 'sq ft',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:const  BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.grey.shade300,style: BorderStyle.solid),
                          ),
                          focusedBorder: OutlineInputBorder(
                           borderRadius:const BorderRadius.all(Radius.circular(15)),
                           borderSide: BorderSide(color: Colors.grey.shade300,style: BorderStyle.solid),
                          )
                        ),

                          
                        ),
                      )
                    ,)
                  ],
                ),
                Divider(endIndent: 30,indent: 30,color: Colors.grey.shade200,thickness: 2,),
                const SizedBox(height: 20,),
                Text('Bedrooms',style: GoogleFonts.varelaRound(fontSize:22,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List<Widget>.generate(
                    6,
                    (int index){
                    return ChoiceChip(
                      labelPadding:const EdgeInsets.symmetric(vertical:8,horizontal: 15),
                      selectedColor: clear,
                      backgroundColor:Colors.grey.shade100,
                      side: BorderSide(color: Colors.grey.shade200),
                      labelStyle: TextStyle(color:selectedbed==index? Colors.white:Colors.black,fontSize: 15),
                      label: Text(index==5?'$index +':'$index'), 
                      selected: selectedbed==index,
                      onSelected: (bool selected){
                        setState(() {
                          selectedbed=selected? index:null;
                        });
                      },
                    );}
                  ).toList()
                ),           
                const SizedBox(height: 20,),
                Divider(endIndent: 30,indent: 30,color: Colors.grey.shade200,thickness: 2,),
                const SizedBox(height: 20,),
                Text('Bathrooms',style: GoogleFonts.varelaRound(fontSize:22,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List<Widget>.generate(
                    6,
                    (int index){
                    return ChoiceChip(
                      labelPadding:const EdgeInsets.symmetric(vertical:8,horizontal: 15),
                      selectedColor: clear,
                      backgroundColor:Colors.grey.shade100,
                      side: BorderSide(color: Colors.grey.shade200),
                      labelStyle: TextStyle(color:selectedbath==index? Colors.white:Colors.black,fontSize: 15),
                      label: Text(index==5?'$index +':'$index'), 
                      selected: selectedbath==index,
                      onSelected: (bool selected){
                        setState(() {
                          selectedbath=selected? index:null;
                        });
                      },
                    );}
                  ).toList()
                ),  
                const SizedBox(height: 20,),
                Divider(endIndent: 30,indent: 30,color: Colors.grey.shade200,thickness: 2,),
                const SizedBox(height: 20,),
                Text('Kitchens',style: GoogleFonts.varelaRound(fontSize:22,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Wrap(
              spacing: 6,
              runSpacing: 6,
              children: List<Widget>.generate(
                6,
                (int index){
                return ChoiceChip(
                  labelPadding:const EdgeInsets.symmetric(vertical:8,horizontal: 15),
                  selectedColor: clear,
                  backgroundColor:Colors.grey.shade100,
                  side: BorderSide(color: Colors.grey.shade200),
                  labelStyle: TextStyle(color:selectedkitch==index? Colors.white:Colors.black,fontSize: 15),
                  label: Text(index==5?'$index +':'$index'), 
                  selected: selectedkitch==index,
                  onSelected: (bool selected){
                    setState(() {
                      selectedkitch=selected? index:null;
                    });
                  },
                );}
              ).toList()
            ),  
                const SizedBox(height: 20,),
                Divider(endIndent: 30,indent: 30,color: Colors.grey.shade200,thickness: 2,),
                const SizedBox(height: 20,),
                Text('Parkings',style: GoogleFonts.varelaRound(fontSize:22,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Wrap(
              spacing: 6,
              runSpacing: 6,
              children: List<Widget>.generate(
                6,
                (int index){
                return ChoiceChip(
                  labelPadding:const EdgeInsets.symmetric(vertical:8,horizontal: 15),
                  selectedColor: clear,
                  backgroundColor:Colors.grey.shade100,
                  side: BorderSide(color: Colors.grey.shade200),
                  labelStyle: TextStyle(color:selectedpark==index? Colors.white:Colors.black,fontSize: 15),
                  label: Text(index==5?'$index +':'$index'), 
                  selected: selectedpark==index,
                  onSelected: (bool selected){
                    setState(() {
                      selectedpark=selected? index:null;
                    });
                  },
                );}
              ).toList()
            ),  
                const SizedBox(height: 20,),
                
      
                
                ],
                  
                ),
          ),
               
        
      ),
    );
  }
}