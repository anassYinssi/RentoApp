
// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:rento/model/user_model.dart';
import 'package:rento/model/house_model.dart';
import 'package:rento/model/services.dart';
import 'package:rento/shared/storage.dart';
import 'package:rento/shared/constants.dart';
import 'package:rento/shared/loding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


class UpdateProfile extends StatefulWidget {

 // UserModel user ;
   const UpdateProfile( {Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}
final _keyForm = GlobalKey<FormState>();

class _UpdateProfileState extends State<UpdateProfile> {
  User?user=FirebaseAuth.instance.currentUser;
  late UserModel loggedinUser;
  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection('users')
    .doc(user!.uid)
    .get()
    .then((value) {
      loggedinUser =UserModel.fromMap(value.data());
      setState(() {
      });

    });
  

  }

  late UserModel usermodel;
  late Housemodel houseModel;
  ImagePicker picker =ImagePicker();
  File?selectedImage;
  Storage storage =Storage();
  
  final username=TextEditingController();
  final image=TextEditingController();
  final tel=TextEditingController();
  final bio=TextEditingController();
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dWhite,
      appBar: AppBar(
        backgroundColor:Colors.white70 ,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: ()=>Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        
        ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                    color:dWhite,
                    borderRadius:const BorderRadius.only(bottomLeft:  Radius.circular(20),bottomRight: Radius.circular(20))
                    ), 
                  ),
                  Positioned(
                    left: 150,
                    top: 50,
                    child: Stack(
                    children: [
                    loggedinUser.image!=null?
                    CircleAvatar(
                      backgroundImage:NetworkImage(loggedinUser.image as String) ,
                      maxRadius: 50,
                    )
                    :const CircleAvatar(
                      backgroundImage:AssetImage('assets/111.png') ,
                      maxRadius: 50,
                    )
                    ,
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: Container(
                        height:30 ,
                        width: 30,
                        decoration:  BoxDecoration(
                          color:dWhite,
                          shape: BoxShape.circle
                        ),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt,
                          color:dBlack),
                          onPressed: ()async{
                          final data= await showModalBottomSheet(context: context,
                          builder:(ctx){
                            return GetImage();
                          } 
                          
                          );
                          if(data!=null){
                          setState(() {
                            selectedImage=data;
                
                          });}
                       


                          },
                        
                        
                        
                        ))),
                                    
                    ]
                                ),
                  ),
            
                
                ]
              ),
              Text(loggedinUser.email,style: GoogleFonts.inter(fontWeight: FontWeight.bold),),
             
              //Divider(thickness: 1,indent: 20,endIndent: 20,),
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                   _TextField(hint:'${loggedinUser.username}', controller:username , validator:_requiredValidator ,) ,              
                    const SizedBox(
                      height: 20,
                    ),
                    _TextField(hint: 'Tel : ${loggedinUser.tel}', controller:tel ,validator: _requiredValidator, ) , 
                    const SizedBox(
                      height: 20,
                    ),
                    _TextField(hint: '${loggedinUser.bio}', controller:bio ,maxlengh: 5,validator: _requiredValidator, ) ,    
                    Center(
                    child: GestureDetector(
                          onTap: ()async{
                            if(selectedImage==null){
                            if(_keyForm.currentState!.validate()){
                            image.text=loggedinUser.username  ;
                            loading(context);
                            await Updateinfo();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();}
                            }else{
                            if(_keyForm.currentState!.validate()){
                            image.text=loggedinUser.username  ;
                            loading(context);
                            await Updateinfo();
                            await updateimage();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();}

                            }


                          

                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 60),
                            height: 50,
                            decoration: BoxDecoration(
                              color: clear,
                              borderRadius: BorderRadius.circular(40)
                        
                            ),
                              child: Center(
                                child: Text(
                                  'UPDATE PROFILE',
                                  style: GoogleFonts.inter(color:Colors.white,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                        ),
                    
                    
                    /*Container(
                      width:100,
                      child: FlatButton(
                        color: SuperClear,
                        onPressed: ()async {
                          if(_keyForm.currentState!.validate()){
                            loading(context);
                            await Updateinfo();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();


                          }
                        },
                        child: Text('Update'),))*/
                        ),
 
                  
                    ],               
                
                  ),
                ),
              )
              
            ],
          ),
        ),
      );
      
      
    


  }
    String?_requiredValidator(String?text){
    if(text==null ||text.trim().isEmpty){
      
      return 'This field is required';
    }
    return null;

  }
  // ignore: non_constant_identifier_names
  Widget GetImage(){
   return Container(
     color: clear,
     height: 100,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children:[
         InkWell(
          child:Row(
              children: [
                Text('Take a photo',style: GoogleFonts.inter(color: Colors.white),),
                const Icon(Icons.camera_alt,color: Colors.white,), 

              ],
            ),
            onTap: () async{ 

              final result =await picker.pickImage(source :ImageSource.camera);
              if (result!=null) {
                Navigator.of(context).pop(File(result.path));
              } else{
                return;
               }
            

            }, 
          ),
          InkWell(
            child:Row(
              children: [
                Text('Select from gallery',style: GoogleFonts.inter(color: Colors.white),),
                const Icon(Icons.photo_album,color: Colors.white,), 

              ],
            ),
            onTap: ()async { 
              final result =await picker.pickImage(source:ImageSource.gallery);
              if(result!=null){
              Navigator.of(context).pop(File(result.path));}
              else{
                return;
              }
            }, 
          ),

       ]
     ),
   );



  }
// ignore: non_constant_identifier_names
Updateinfo()async{
    User?user= FirebaseAuth.instance.currentUser;
    await Service().updateProfile(username.text, bio.text, tel.text, user!.uid);

  Fluttertoast.showToast(msg: "Profile updated succesfully");

}
updateimage()async{

    User?user= FirebaseAuth.instance.currentUser;
      String ?url ;
      selectedImage!=null? url =await storage.uploadImage(selectedImage!, '')
      :url=null;
    await Service().updateProfileImage(url, user!.uid);

  Fluttertoast.showToast(msg: "Profile Image updated succesfully");
  Navigator.of(context).pop();


}


 
}
class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final Icon? prefixIcon;
  final String hint ;  
  final TextInputType? keboardType;
  final FormFieldValidator<String>? validator;
  final int? maxlengh;


  const _TextField({
    required this.hint,
    required this.controller,
    this.keboardType, 
    this.validator,
    this.prefixIcon,
    this.maxlengh

  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child:TextFormField(
        keyboardType: keboardType,         
        validator: validator,
        maxLines: maxlengh,       
        controller: controller,
        decoration:InputDecoration(
        filled:true,
        fillColor: superClear.withOpacity(0.1),
        hintText: hint,
        suffixIcon: Icon(Icons.edit,color:dark,) ,       
        enabledBorder:  OutlineInputBorder(
        borderSide:BorderSide(color:clear,width: 0.5) 
        )
        ),
              ),
    );
    
  }
}