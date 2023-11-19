import 'package:flutter/material.dart' ;

import '../../Pallate.dart';
import '../../custom_widgets/home_page_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            children: [
              SizedBox(width: 13,),
              OptionContainer(icon: Icon(Icons.video_call,size: 28,), text: 'New Meeting', color: Colors.red.shade400,),
              SizedBox(width: 30,),
              OptionContainer(icon: Icon(Icons.add,color: Colors.white,size: 28,), text: 'Join Meeting', color: AppColors.theme['primaryColor'],),
              SizedBox(width: 30,),
              OptionContainer(icon: Icon(Icons.schedule,color: Colors.white,size: 28,), text: 'Schedule', color:AppColors.theme['primaryColor'],),
              SizedBox(width: 30,),
              OptionContainer(icon: Icon(Icons.ios_share_sharp,color: Colors.white,size: 28), text: 'Share Screen', color: AppColors.theme['primaryColor'],),
              SizedBox(width: 13,),
            ],
          ),
        )
      ),
    );;
  }
}
