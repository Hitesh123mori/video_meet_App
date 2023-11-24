import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zoom_clone/effects/transition5.dart';

import '../../Pallate.dart';
import '../../custom_widgets/home_page_container.dart';
import '../../custom_widgets/upcoming_timer.dart';
import '../../resources/Api.dart';
import '../../resources/models/meeting.dart';
import '../home_page_screens/join_meeting_screen.dart';
import '../home_page_screens/new_meeting.dart';
import '../home_page_screens/new_meeting_details.dart';
import '../home_page_screens/schedule_meeting.dart';
import '../splash_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? timer;
  Duration? remainingTime;
 List<Meeting> list = [] ;


  @override
  void initState() {
    super.initState();
    Api.getSelfData(Api.user.uid);
  }



  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      SizedBox(width: mq.width * 0.05),
                      OptionContainer(
                        icon: Icon(Icons.video_call,
                            size: 28, color: Colors.white),
                        text: 'New Meeting',
                        color: Colors.orange.shade800,
                        onTap: () {
                          Navigator.push(
                              context, SizeTransition5(MeetingDetails()));
                        },
                      ),
                      SizedBox(
                        width: mq.width * 0.05,
                      ),
                      OptionContainer(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 28,
                        ),
                        text: 'Join Meeting',
                        color: AppColors.theme['primaryColor'],
                        onTap: () {
                          Navigator.push(
                              context, SizeTransition5(JoinMeeting()));
                        },
                      ),
                      SizedBox(
                        width: mq.width * 0.05,
                      ),
                      OptionContainer(
                        icon: Icon(
                          Icons.schedule,
                          color: Colors.white,
                          size: 28,
                        ),
                        text: 'Schedule',
                        color: AppColors.theme['primaryColor'],
                        onTap: () {
                          Navigator.push(
                              context, SizeTransition5(ScheduledMeeting()));
                        },
                      ),
                      SizedBox(
                        width: mq.width * 0.05,
                      ),
                      OptionContainer(
                        icon: Icon(Icons.ios_share_sharp,
                            color: Colors.white, size: 28),
                        text: 'Share Screen',
                        color: AppColors.theme['primaryColor'],
                        onTap: () {},
                      ),
                      SizedBox(
                        width: mq.width * 0.05,
                      ),
                    ],
                  ),
                ),

                // Text(
                //   'Remaining Time: ${remainingTime?.inHours ?? 0}h ${remainingTime?.inMinutes.remainder(60) ?? 0}m ${remainingTime?.inSeconds.remainder(60) ?? 0}s',
                //   style: TextStyle(fontSize: 18),
                // ),

                Divider(height: 0.5,),
                Padding(
                  padding: EdgeInsets.only(right: mq.width*0.4,top: mq.height*0.03),
                  child: Text("     Your Upcoming Meetings",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                ),
                StreamBuilder(
                    stream: Api.fetchUpcomingMeeting(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                        // return const Center(
                        //   child: CircularProgressIndicator(),
                        // );
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          list = data
                                  ?.map((e) => Meeting.fromJson(e.data()))
                                  .toList() ??
                              [];
                          print("#length :  ${list.length}");

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            child: list.isEmpty
                                ? Center(
                                    child:Padding(
                                      padding:  EdgeInsets.symmetric(vertical: mq.height*0.3),
                                      child: Text(
                                                                        "No Scheduled Meetings",
                                                                        style: TextStyle(color: Colors.blueGrey, fontSize: 26),
                                                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: list.length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index){

                                      return UpcomingTimer(meeting: list[index],) ;

                                    },
                                  ),
                          );
                      }
                    }),
              ],
            ),
          )),
    );
    ;
  }
}
