import 'package:flutter/material.dart' ;
import 'package:flutter/services.dart';
import 'package:zoom_clone/effects/transition4.dart';

import '../pallate.dart';
import '../resources/Api.dart';
import 'home_screen.dart';
import 'login_screen.dart';

late Size mq ;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override

  void initState(){
    super.initState() ;
    Future.delayed(Duration(milliseconds: 2500),(){
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge) ;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent,systemNavigationBarColor: Colors.transparent));
      if(Api.auth != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen())) ;
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen())) ;
      }
    }) ;
  }


  @override
  Widget build(BuildContext context) {

    mq = MediaQuery.of(context).size ;
    return Scaffold(
      backgroundColor: AppColors.theme['primaryColor'],
      body:Center(
        child:Image.asset("assets/images/img.png",height: 250,width: 250,),
      )
    );
  }
}

