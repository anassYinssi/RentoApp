
import 'dart:async';
import 'package:rento/shared/constants.dart';
import 'package:rento/shared/loding.dart';
import 'package:rento/views/screens/Auth/sign_up.dart';
import 'package:rento/views/screens/Auth/header.dart';
import 'package:rento/views/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
bool isHiddenPassword =true;


class _LoginPageState extends State<LoginPage> {
  
final double _headerHeigh =250;
bool isLoding=false;
final _formKey =GlobalKey<FormState>();
final auth =FirebaseAuth.instance ;

  @override
  Widget build(BuildContext context) {

    TextEditingController _emailController =TextEditingController();
    TextEditingController _passwordController =TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset:false,
      body:Column(
            children: [
              SizedBox(
              height: _headerHeigh,
              child: HeaderWidget(_headerHeigh,false,Icons.login_rounded)),
              Form(
                key: _formKey,
                child: 
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 100,),
                    CustomTextField(controller: _emailController, 
                    validator: emailValidator,
                    label: 'Email', isPassword: false,
                    prefixIcon: Icon(Icons.email,color: clear,)),
                    const SizedBox(height: 20,),
                    CustomTextField(
                      controller: _passwordController, 
                      label: 'Password',validator: passwordValidator, 
                      prefixIcon: Icon(Icons.vpn_key,color: clear,),
                      isPassword: true,
                    ),
                    const SizedBox(height: 6,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal:12),
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.centerRight,
                      child: Text('Forgot your password ?',
                      style: GoogleFonts.fredokaOne(
                        color:superClear,
                        //fontWeight: FontWeight.bold,
                      ),)),
                    const SizedBox(height: 20,),
                      
                    Container(
                      color: clear,
                      child:MaterialButton(
                      
                        onPressed:(){
                          loading(context);
                          signIn(_emailController.text,_passwordController.text);
                      
                        },
                        
                        
                        minWidth:200,
                        padding: const EdgeInsets.fromLTRB(20,15,20,15),
                        child:isLoding? const CircularProgressIndicator(color: Colors.white,): Text('SIGN IN',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                        
                    ),),
                    InkWell(
                      child: Row(
                        children: const[
                          Text("Skip Login"),
                          Icon(Icons.arrow_circle_right)
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SplashScreen()));
                      },
                    ),
                   
                    const SizedBox(height: 150,),
                    
                    Divider(
                      color: clear,
                      thickness: 1,
                      indent: 80,
                      endIndent: 80,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text('You don\'t have an account ? ',
                        style: GoogleFonts.inter(color: superClear,fontWeight: FontWeight.normal),),
                        GestureDetector(
                          child:  Text('SIGN UP',
                          style:TextStyle( color: clear,fontWeight: FontWeight.bold),),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return  const Registre1();
                            }));
                          },
                        ),
                        
                    ],),
                    
                  
                  ],
                ),
              )
              
              ),
                
               
                  
                ],
              
              )
           
    
     
    );



    
  }


  void signIn(String email ,String password) async{
    if(_formKey.currentState!.validate()){
    try{
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    await auth
    .signInWithEmailAndPassword(email:email, password: password)
    .then((uid) => {
        prefrences.setString('email',email),
        Fluttertoast.showToast(msg: "Login successful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const SplashScreen())),
      });
    }on FirebaseAuthException catch(e){
      Fluttertoast.showToast(msg: e.message as String);
      Timer(const Duration(seconds: 3), ()=>Navigator.of(context).pop());
      
    }
    
    }
    
  }

  String? emailValidator(String?text){
    
    if(text==null ||text.trim().isEmpty){
      return("Please Enter You E-mail");
    }
    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]").hasMatch(text)){
      return"Please Enter A Valid Emil";
    }
    return null;
  }

  String? passwordValidator(String?text){

    RegExp regex= RegExp(r'^.{6,}$');
    if(text==null ||text.trim().isEmpty){
      return "Password is required ";
    }
    if(!regex.hasMatch(text)){

      return"Please Enter a Valid Password (Minimum 6 characters)";

    }
    return null;
  }

 

}


