import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/Pallate.dart';
import 'package:zoom_clone/screens/splash_screen.dart';

import '../custom_widgets/button.dart';
import '../custom_widgets/cutsom_helpers.dart';
import '../effects/transition4.dart';
import '../effects/transition5.dart';
import '../resources/Api.dart';
import 'login_screen.dart';

class GreetScreen extends StatefulWidget {
  const GreetScreen({super.key});

  @override
  State<GreetScreen> createState() => _GreetScreenState();
}

class _GreetScreenState extends State<GreetScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children:[
                SizedBox(height: mq.height*0.037,),
                Text("You're ready to go!",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22),) ,
                SizedBox(height: mq.height*0.017,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: mq.width*0.04),
                  child: Text("Welcome to MeetWith for video meeting,",style: TextStyle(fontSize: 14),),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: mq.width*0.2),
                  child: Text("chat,and more."),
                ),
                SizedBox(height: mq.height*0.1,),
                Image.asset("assets/images/greet_card.jpg",width: 350,height: 350,),
                SizedBox(height: mq.height*0.15,),
                customButton(onPressed: () async{


                 await Api.signOut(context) ;


                }, text: 'Get Started', textColor:AppColors.theme['primaryTextColor'], buttonColor: AppColors.theme['primaryColor'],)
              ]

            ),
          ),
        ),

      ),
    );
  }
}
