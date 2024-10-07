
// ignore_for_file: deprecated_member_use

import 'package:rento/model/user_model.dart';
import 'package:rento/shared/constants.dart';
import 'package:rento/views/screens/Auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/Firestore_helper.dart';
import '../../../shared/widgets/custom_text_field.dart';


class Registre1 extends StatefulWidget {
  const Registre1({ Key? key }) : super(key: key);

  @override
  State<Registre1> createState() => _Registre1State();
}

class _Registre1State extends State<Registre1> {
  FirebaseAuth auth =FirebaseAuth.instance;
  final _keyForm= GlobalKey<FormState>();
  final username=TextEditingController();
  final email=TextEditingController();
  final password=TextEditingController();
  final secondPassword=TextEditingController();
  final phone=TextEditingController();
  var loading =false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 15,
        backgroundColor: clear,
        shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomLeft: Radius.circular(200),bottomRight: Radius.circular(200) )),
        bottom: PreferredSize(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('SIGN UP',
              style: GoogleFonts.fredokaOne(fontSize: 25,color: Colors.white),),
              const SizedBox(height: 20,),
              Text("Welcome to our company!\nWe're so excited to have you as part of our team",textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 12,color: Colors.white54,fontWeight: FontWeight.bold)),
              const SizedBox(height: 40,)
            ],
          ),  
          preferredSize: const Size.fromHeight(70)),
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
            ),
            CustomTextField(controller: username, label: 'Username', isPassword: false, validator: _requiredValidator,prefixIcon: Icon(Icons.person,color: clear,),),
            const SizedBox(height: 20,),
            CustomTextField(controller: email, label: 'Email', isPassword: false, validator:_emailValidator ,keboardType: TextInputType.emailAddress,prefixIcon: Icon(Icons.email,color: clear)),
            const SizedBox(height: 20,),
            CustomTextField(controller: phone, label: 'Phone', isPassword: false,keboardType:const TextInputType.numberWithOptions(decimal: true),prefixIcon: Icon(Icons.phone,color: clear)),
            const SizedBox(height: 20,),
            CustomTextField(controller: password, label: 'Password', isPassword: true ,validator:_passwordValidator ,prefixIcon: Icon(Icons.vpn_key,color: clear),sufixIcon: Icon(Icons.visibility,color: clear)),
            const SizedBox(height: 20,),
            CustomTextField(controller: secondPassword, label: 'Password', isPassword: true,validator: _confirmPasswordValidator,prefixIcon: Icon(Icons.vpn_key,color: clear,),sufixIcon: Icon(Icons.visibility,color: clear),),
            const SizedBox(height: 20,),
            if(loading)...[
              const Center(
                child: CircularProgressIndicator(),
              )

            ],
            if(!loading)...[

            Container(
              decoration:const BoxDecoration(
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: (){
                  if(_keyForm.currentState !=null && _keyForm.currentState!.validate()){
                    FirestoreHelper.create(UserModel(
                      username: username.text,
                      tel: phone.text,
                      email: email.text,
                    ));

                  }
                },
                child: Text('sign up' ,style: GoogleFonts.inter(fontSize: 22 ,color: dWhite),),
              ),
            )
            ]
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
String?_confirmPasswordValidator(String?text){
    if(text==null ||text.trim().isEmpty){
      return 'This field is required';
    }
    if(password.text != secondPassword.text){
      return'No match password ';
    }
    return null;


  }  

 String?_emailValidator(String?text){
    if(text==null ||text.trim().isEmpty){
      return("Please Enter You E-mail");
    }
    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]").hasMatch(text)){
      return"Please Enter A Valid Email";
    }
    return null;

  }
  String?_passwordValidator(String?text){
    RegExp regex= RegExp(r'^.{6,}$');
    if(text==null ||text.trim().isEmpty){
      return "Password is required ";
    }
    if(!regex.hasMatch(text)){

      return"Please Enter a Valid Password (Minimum 6 characters)";

    }
    return null;

  }



Future signUp( )async{
  
  if(_keyForm.currentState!.validate() ){
    try{
    await auth.createUserWithEmailAndPassword(email: email.text, password: password.text)
    .then((value) => {
      postDetailsToFirestore()
      

    });
    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message as String);

    }

  }

    await showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('SignUp succeeded'),
      content: const Text('Your account was created successfuly , you can now log in'),
      actions: [
        InkWell(onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => const LoginPage())));

        }, 
        child:const Text('Ok'))
      ],

    ));



}



postDetailsToFirestore()async{

  FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;

  User?user=auth.currentUser;

  UserModel userModel=UserModel(email: email.text, username: username.text, tel: phone.text,uid:user!.uid);

 

  await firebaseFirestore
  .collection("users")
  .doc(user.uid)
  .set(userModel.toMap());// la fonction toMap() est implémenté dans un autre fichier c'est celle qui fait le remplissage des champs

}



  
}

