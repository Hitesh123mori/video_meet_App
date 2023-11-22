import 'package:flutter/material.dart' ;
import 'package:zoom_clone/effects/transition5.dart';

import '../../Pallate.dart';
import '../../custom_widgets/home_page_container.dart';
import '../home_page_screens/join_meeting_screen.dart';
import '../home_page_screens/new_meeting.dart';
import '../splash_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor:Colors.grey.shade100,
        body:SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    SizedBox(width: mq.width*0.03),
                    OptionContainer(icon: Icon(Icons.video_call,size: 28,color: Colors.white), text: 'New Meeting', color: Colors.orange.shade800, onTap: () {
                      Navigator.push(context,SizeTransition5(NewMeeting())) ;
                    },),
                    SizedBox(width: mq.width*0.05,),
                    OptionContainer(icon: Icon(Icons.add,color: Colors.white,size: 28,), text: 'Join Meeting', color: AppColors.theme['primaryColor'], onTap: () {
                      Navigator.push(context, SizeTransition5(JoinMeeting())) ;
                    },),
                    SizedBox(width:mq.width*0.05,),
                    OptionContainer(icon: Icon(Icons.schedule,color: Colors.white,size: 28,), text: 'Schedule', color:AppColors.theme['primaryColor'], onTap: () {  },),
                    SizedBox(width: mq.width*0.05,),
                    OptionContainer(icon: Icon(Icons.ios_share_sharp,color: Colors.white,size: 28), text: 'Share Screen', color: AppColors.theme['primaryColor'], onTap: () {  },),
                    SizedBox(width: mq.width*0.01),
                  ],
                ),
              ),
              SizedBox(height: mq.height*0.14,),
              Image.asset("assets/images/no_meet.png"),
              Text("No Meetings",style: TextStyle(color:Colors.blueGrey,fontSize: 32),),
            ],
          ),
        )
      ),
    );;
  }
}
