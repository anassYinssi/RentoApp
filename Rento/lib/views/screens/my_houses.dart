import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rento/model/services.dart';
import 'package:rento/services/Firestore_helper.dart';
import 'package:rento/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rento/shared/loding.dart';
import 'package:rento/views/screens/update_house.dart';

import '../../model/house_model.dart';

class HouseList extends StatefulWidget {
  const HouseList({ Key? key }) : super(key: key);

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  
  final styleText =const TextStyle(
    color: Color(0XFF042037),fontWeight: FontWeight.bold
  );
  final form1key= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: activeContent()
    );
        
    
  }
  Widget activeContent(){
    return StreamBuilder<List<Housemodel>> (
      stream: FirestoreHelper.readOwnerShip(),
      builder:(context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent,),);
        }
        if(snapshot.hasError){
          throw snapshot.error!;
        }
        if(snapshot.hasData){  
          final houseData = snapshot.data;       
          return ListView.builder(
          itemCount: houseData!.length,
          itemBuilder: (cxt ,int index){ 
            final house =houseData[index];
            TextEditingController title = TextEditingController();
            TextEditingController aire = TextEditingController();
            TextEditingController priceNight = TextEditingController();
            TextEditingController priceMonth = TextEditingController();
            TextEditingController priceYear = TextEditingController();
            TextEditingController adress = TextEditingController();
            TextEditingController about = TextEditingController();
            title.text=house.name;
            adress.text=house.adress;
            priceNight.text='${house.priceNight}';
            priceMonth.text='${house.priceMonth}';
            priceYear.text='${house.priceYear}';
            aire.text='${house.aire}';
            about.text=house.about;
            return Material(
              child: ListTile(
                onTap: (){
                },
                isThreeLine: true,
                subtitle: Text('In ${house.adress}',style: GoogleFonts.ibmPlexSans(fontSize:12),),
                leading: Stack(
                  children: [
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: ClipRRect(
                        borderRadius:const BorderRadius.all(Radius.circular(5)),
                        child: CachedNetworkImage(imageUrl: house.images.first,fit: BoxFit.cover,placeholder: (context, url) => Container(color: Colors.grey.shade200,),)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                      borderRadius:const BorderRadius.all(Radius.circular(5)),
                      color: Colors.black.withOpacity(0.4),
                      ), 
                      height: 90,
                      width: 90,
                      child: IconButton(
                        icon:const Icon(Icons.edit),
                        color: Colors.white,
                        onPressed: (){
                          showModalBottomSheet(
                            context: context, 
                            builder: (context)=>SizedBox(
                              height: 200,
                              child: Column(
                                children: [
                                  Expanded(child:InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset("assets/photo10.svg",height: 30,width: 30,),
                                          const SizedBox(width: 10,),
                                          const Text("Edit photos")
                                        ],
                                      ),
                                    ),
                                    onTap: (){},
                                  )),
                                  Expanded(child:InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset("assets/edit9.svg",height: 30,width: 30,),
                                          const SizedBox(width: 10,),
                                          const Text("Edit post information")
                                        ],
                                      ),
                                    ),
                                    onTap: (){
                                      showModalBottomSheet(
                                      isScrollControlled: true,
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top:Radius.circular(30))
                                      ),
                                      context: context,
                                      builder: (context)=> DraggableScrollableSheet(
                                          minChildSize: 0.7,
                                          initialChildSize:0.7,
                                          //maxChildSize: 0.9,
                                          expand: false,
                                          builder:(_,controller)=> ListView(
                                            controller: controller,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.symmetric(vertical:10,horizontal: 170),
                                                height: 5,
                                                decoration:const BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        const Text('State',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                                        ReservationBouton(Colors.amber, true)
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20,),
                                                    SingleChildScrollView(
                                                      child: SizedBox(
                                                        child: Form(
                                                          key: form1key,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text('Title',style: styleText,),
                                                              _TextField(padding: 5, controller: title,maxLenght: 20,validator: _requiredValidator,),
                                                              Text('Adress',style: styleText),
                                                              _TextField(padding: 5, controller: adress,maxLenght: 40,),
                                                              Text('Aire',style: styleText),
                                                              _TextField(padding: 5, controller: aire,suffixText: 'm2',keboardType: TextInputType.number,validator: _requiredValidator,),
                                                              Text('Price Night',style: styleText),
                                                              _TextField(padding: 5, controller: priceNight,suffixText:'\$ / Night',keboardType: TextInputType.number,validator: _requiredValidator,),
                                                              Text('Price Month',style: styleText),
                                                              _TextField(padding: 5, controller: priceMonth,suffixText:'\$ / Month',keboardType: TextInputType.number,),
                                                              Text('Price Year',style: styleText),
                                                              _TextField(padding: 5, controller: priceYear,suffixText:'\$ / Year',keboardType: TextInputType.number,),
                                                              Text('About',style: styleText),
                                                              _TextField(padding: 5, controller: about,maxlines: 4,maxLenght: 700,validator: _descriptionValidator,),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ), 
                                              Center(
                                                child: InkWell(
                                                  borderRadius:BorderRadius.circular(20) ,
                                                  splashColor: Colors.white.withOpacity(0.2),
                                                  //highlightColor: Colors.green,
                                                  child: Ink(
                                                    height: 60,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius: BorderRadius.circular(20)
                                                    ),
                                                    child:const Center(child:Text('Save',style: TextStyle(fontWeight: FontWeight.bold),)),
                                                  ),
                                                
                                                onTap: ()async{
                                                  loading(context);
                                                  if(form1key.currentState!.validate()){
                                                    CollectionReference allhouses =FirebaseFirestore.instance.collection('allHouses');
                                                    await allhouses
                                                    .doc(house.postID)
                                                    .update(
                                                      {
                                                        'name':title.text,
                                                        'adress':adress.text,
                                                        'priceNight':double.parse(priceNight.text),
                                                        'priceMonth':double.parse(priceMonth.text),
                                                        'priceYear':double.parse(priceYear.text),
                                                        'aire':double.parse(aire.text),
                                                        'about':about.text,
                                                      }
                                                    ).whenComplete(()=>ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(content: Row(
                                                          children: [
                                                            SvgPicture.asset("assets/done.svg",color: Colors.white,width: 30,height: 30,),
                                                            const SizedBox(width: 10,),
                                                            const Text('Updated succesfully',style: TextStyle(fontWeight: FontWeight.w500),),
                                                          ],
                                                        ),
                                                        behavior: SnackBarBehavior.floating,
                                                        backgroundColor: Colors.green,
                                                        margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                                        )
                                                      )
                                                      );

                                                  }
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);

                                                },
                                              ),
                                              ),   
                                            ],
                                          ),
                                        ),
                                      
                                    );
                                    },
                                  )),
                                  Expanded(child:InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset("assets/edit9.svg",height: 30,width: 30,),
                                          const SizedBox(width: 10,),
                                          const Text("Edit Features")
                                        ],
                                      ),
                                    ),
                                    onTap: (){},
                                  )),
                                ],
                              ),
                            )
                          );

                          /**/
                        },
                        ),
                    )
                  ],
                ),
                title: Text(house.name,style: GoogleFonts.bebasNeue(fontSize: 20) ),
                trailing:
                    GestureDetector(
                      child: ReservationBouton(Colors.greenAccent,house.etat),
                      onTap: (){
                        Service().updateEtat(house.postID, house.etat);
                      },
                    ),                        
              ),
            );
                    
          },
                    
          );

        }
        return const Center(child: Text("No post availiable"),);
      }
       
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
  Widget updateContent(){
    return const UpdateHouse();

  }
  Widget makeDismissible({required Widget child})=>GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: (){
      Navigator.of(context).pop();
    },
    child: GestureDetector(child: child,onTap: (){},),

  );

  
  
}

class ReservationBouton extends StatelessWidget{
  final Color? bouttonColor ;
  bool? etat;
  ReservationBouton(
    this.bouttonColor,
    this.etat, {Key? key}
  ) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
        color:etat==true? bouttonColor:Colors.grey,
        borderRadius:const BorderRadius.all(Radius.circular(30)),
      ),
      child: Stack(children: [
        etat==false?
          AnimatedAlign(
            alignment: Alignment.centerRight,
            duration: const Duration(milliseconds: 600),
            curve: Curves.fastOutSlowIn,
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
              color: dWhite,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
            ),
        )
        :AnimatedAlign(
          alignment: Alignment.centerLeft,
          duration: const Duration(milliseconds:600),
          curve: Curves.fastOutSlowIn,
            child: Container(
              height: 28,
              width: 28,
              decoration:  BoxDecoration(
              color: dWhite,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
            ),
          ),
        


      ]),




    );
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
      padding:  EdgeInsets.symmetric(horizontal: padding,vertical: 10),
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
          fillColor:const Color(0XFF718DA5),
          //const Color.fromARGB(255, 208, 228, 236),
          hintText: hint,
        ),
        onChanged: validator,
        style:const  TextStyle(color: Colors.white,),
        maxLines: maxlines,
        validator: validator,

      ),
    );
    
  }
}


