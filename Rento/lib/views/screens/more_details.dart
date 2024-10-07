
// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rento/services/custom_page_route.dart';
import 'package:rento/shared/widgets/custom_button.dart';
import 'package:rento/views/select_equipements.dart';

import '../../shared/delay.dart';
class MoreDetails extends StatefulWidget {
  static const routeName ='/MoreDetails -screen';
  static TextEditingController title = TextEditingController();
  static TextEditingController aire = TextEditingController();
  static TextEditingController priceNight = TextEditingController();
  static TextEditingController priceMonth = TextEditingController();
  static TextEditingController priceYear = TextEditingController();
  static TextEditingController adress = TextEditingController();
  static TextEditingController about = TextEditingController();
  List<File> images;
  String category;
  String city;
  MoreDetails({Key? key,
  required this.category,
  required this.city,
  required this.images}) : super(key: key);

  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  
  final myKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  color: Colors.deepPurple,
                  height: 10,
                  width: 3*MediaQuery.of(context).size.width/7,
                        
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade100,
                child: const Center(
                  child: Text('Post details',
                    style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    
                    ),
                ),
              )
            ),
            Expanded(
              flex: 8,
              child:
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: myKey,
                child:ListView(
                    children: [
                      const SizedBox(height: 20,),
                      Padding(
                        padding:const  EdgeInsets.symmetric(horizontal :14.0),
                        child: Align(child: Row(
                          children:const [
                            Text('Title',
                            style: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),
                            ),
                            Text('*',style: TextStyle(color: Colors.red),)
                          ],
                        ),alignment: Alignment.centerLeft,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:10.0),
                        child: Center(child: _TextField(padding: 20, controller: MoreDetails.title,maxLenght: 20,validator: _requiredValidator,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal :14.0),
                        child: Align(child: Row(
                          children:const  [
                            Text('Adress',
                            style: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),),
                            Text('*',style: TextStyle(color: Colors.red),)
                          ],
                        ),
                        alignment: Alignment.centerLeft,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:10.0),
                        child: Center(child: _TextField( maxLenght: 40 ,validator: _requiredValidator,padding: 20, controller: MoreDetails.adress, prefixIcon: Icon(Icons.place,color: Colors.grey.shade100,)
                        )),
                      ),
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal :14.0),
                        child: Align(child: Row(
                          children: const[
                            Text('Aire',
                            style: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),
                            ),
                            Text('*',style: TextStyle(color: Colors.red),)
                          ],
                        ),alignment: Alignment.centerLeft,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:10.0),
                        child: Center(child: Align(
                          alignment: Alignment.centerRight,
                          child: _TextField(
                            validator:_requiredValidator,
                            padding: 20,
                            controller: MoreDetails.aire,
                            suffixText: 'm2',
                            keboardType: TextInputType.number,
                            prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset('assets/layers.svg',width:5 ,height: 5,color: Colors.grey.shade100,),),
          
                          ),
                        )),
                      ),
                      Padding(
                        padding:const EdgeInsets.symmetric(horizontal :14.0),
                        child: Align(child: Row(
                          children:const [
                            Text('Price', 
                            style: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),),
                            Text('*',style: TextStyle(color: Colors.red),)
                          ],
                        ),alignment: Alignment.centerLeft,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:10.0),
                        child: Center(child: _TextField(padding: 20, controller: MoreDetails.priceNight,suffixText:'\$ / night',keboardType: TextInputType.number,validator: _requiredValidator,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:10.0),
                        child: Center(child: _TextField(padding: 20, controller: MoreDetails.priceMonth,suffixText:'\$ / month',keboardType: TextInputType.number,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:10.0),
                        child: Center(child: _TextField(padding: 20, controller: MoreDetails.priceYear,suffixText:'\$ / year',keboardType: TextInputType.number,)),
                      ),
                      Padding(
                        padding:const  EdgeInsets.symmetric(horizontal :14.0),
                        child: Align(child: Row(
                          children:const [
                            Text('Description',
                            style: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),),
                            Text('*',style: TextStyle(color: Colors.red),),
                          ],
                        ),alignment: Alignment.centerLeft,),
                      ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:10.0),
                          child: Center(child: _TextField(padding: 20, controller: MoreDetails.about,maxlines: 4,maxLenght: 700,validator: _descriptionValidator,)),
                        ),
                    ],
                  ),
              ),),
            Expanded(
              flex: 2,
              child: Row(
                children:[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 60,
                      child: CustomButton(
                        text: 'BACK',
                        onPressed: ()async{
                          await delay(200);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
        
                  ),
                  Expanded(
                    flex: 1,
                    child:Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 60,
                      child: CustomButton(
                        text: 'NEXT',
                        onPressed: ()async{
                          await delay(200);
                          if(myKey.currentState!.validate()){
                          Navigator.of(context).pushNamed(SelectEquipements.routeName);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Row(
                              children: [
                                SvgPicture.asset("assets/attention.svg",color: Colors.white,width: 30,height: 30,),
                                const SizedBox(width: 10,),
                                const Text('Please complete the form',style: TextStyle(fontWeight: FontWeight.w500),),
                              ],
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                            )
                          );
                          }
                        },
                      ),
                    ),
                  )
                ]
              )
            )
        
          ],
        ),
    );
   
  }
  String?_requiredValidator(String?text){
    if(text==null ||text.trim().isEmpty){
      return '* This field is required';
    }
    return null;
  }
  String?_descriptionValidator(String?text){
    if(text==null ||text.trim().isEmpty){
      return '* This field is required';
    }else if(text.length<10){
      return "* You should put more than 10 characters";

    }
    return null;
  }
}
class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final int?maxlines;
  final Widget? prefixIcon;
  final Icon ?sufixIcon;
  final String ?hint;
  final TextInputType? keboardType;
  final int? maxLenght ;
  final double padding;
  final String ? suffixText;
  final FormFieldValidator<String>? validator;

   const _TextField({
    required this.padding,
    this.hint,
    this.maxlines,
    required this.controller,
    this.keboardType, 
    this.validator,
    this.suffixText,
    this.prefixIcon,
    this.sufixIcon,
    this.maxLenght


  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: padding),
      child: TextFormField(
        textCapitalization: TextCapitalization.values.first,
        maxLength: maxLenght,
        cursorHeight: 25,
        cursorWidth: 1,
        cursorColor: Colors.grey.shade100,
        controller: controller,
        keyboardType: keboardType,
        decoration: InputDecoration(
          suffixText:suffixText ,
          border: InputBorder.none,
          filled: true,
          errorStyle: TextStyle(backgroundColor: Colors.grey.shade100,fontWeight: FontWeight.bold,),
          focusedErrorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(14),
           borderSide:  const BorderSide(color: Colors.blueAccent),
          ),
          errorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(14),
           borderSide:  const BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(14),
            borderSide:  BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:BorderRadius.circular(14),
            borderSide: BorderSide.none, 
          ),
          fillColor: const Color.fromARGB(255, 208, 228, 236),
          hintText: hint,
        ),
        onChanged: validator,
        style:const  TextStyle(color: Colors.black54,),
        maxLines: maxlines,
        validator: validator,

      ),
    );
    
  }
}