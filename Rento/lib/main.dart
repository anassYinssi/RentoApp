// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable
import 'package:flutter/services.dart';
import 'package:rento/router.dart';
import 'package:rento/views/screens/Auth/login.dart';
import 'package:rento/views/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rento/views/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email= preferences.get('email');
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark
    )
  );
  runApp( MyApp(email: email,));
}
class MyApp extends StatelessWidget {
  var email;
  MyApp({Key? key,
  required this.email
  }) : super(key: key);    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
  @override

  Widget build(Object context) {
    return MaterialApp(
      home: email==null?const LoginPage():const SplashScreen1(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        //appBarTheme: AppBarTheme(color: blackColor,backgroundColor: Colors.transparent)
      ),
      onGenerateRoute: (settings)=>generateRoute(settings),
    );
    
    
    /*MaterialApp(
      title: 'Rento',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen1()
    );*/

  }

}