import 'package:flutter/material.dart' ;
import 'package:zoom_clone/effects/transition5.dart';
import 'package:zoom_clone/screens/bottom_navigation_screens/contacts.dart';
import 'package:zoom_clone/screens/bottom_navigation_screens/home_page.dart';
import 'package:zoom_clone/screens/bottom_navigation_screens/meeting_history.dart';
import 'package:zoom_clone/screens/bottom_navigation_screens/setting.dart';
import 'package:zoom_clone/screens/splash_screen.dart';

import '../Pallate.dart';
import '../custom_widgets/info_card.dart';
import '../resources/Api.dart';
import 'home_page_screens/new_meeting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  final List<Widget> children = [
    HomePage(),
    History(),
    Contacts(),
    Setting(),
  ];


  @override
  void initState(){
    super.initState() ;
    Api.getSelfData(Api.user.uid) ;
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Icon(Icons.home,color: Colors.white,),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: IconButton(
                  onPressed: (){
                    showBottomSheet();
                  },
                  icon: Icon(Icons.info_outline,color: Colors.white,),
                ),
              )
            ],
            elevation: 0.2,
            backgroundColor: Colors.grey.shade900,
            centerTitle: true,
            title: Text(
              "MeetWith",
              style: TextStyle(color: AppColors.theme['primaryTextColor']),
            ),
          ),
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          selectedItemColor: AppColors.theme['primaryColor'],
          unselectedItemColor: Colors.grey,
          showUnselectedLabels : true,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
        ),

      ),
    );
  }



  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return History();
      case 2:
        return Contacts();
      default:
        return Setting();
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade100,
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    Text('Personal Meeting ID',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text(Api.curUser!.meetingId.replaceAllMapped(
                      RegExp(r".{4}"),
                          (match) => "${match.group(0)} ",
                    ),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal:20,vertical: 10),
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left: 12.0,right: 12),
                                child: InfoCard(icon: Icon(Icons.video_call_outlined), OnTap: () {
                                  Navigator.push(context, SizeTransition5(NewMeeting()));
                                }, text: 'Start Meeting',),
                              ) ,
                              Divider(height: 0.7,color: Colors.grey.shade100,),
                              Padding(
                                padding:  EdgeInsets.only(left: 12.0,right: 12),
                                child: InfoCard(icon: Icon(Icons.share_outlined), OnTap: () {  }, text: 'Send Invitation',),
                              ) ,

                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),

                        height: mq.height*0.11,
                        width: mq.width*0.8,
                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('Cancel')),
                  ],
                )
              ],
            ),
          );
        });
  }

}
