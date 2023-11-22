import 'package:flutter/material.dart' ;

import '../../custom_widgets/displaying_meeting_card.dart';
import '../../resources/Api.dart';
import '../../resources/models/meeting.dart';

class Joined extends StatefulWidget {
  const Joined({super.key});

  @override
  State<Joined> createState() => _JoinedState();
}

class _JoinedState extends State<Joined> {


  List<Meeting> list = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder(
            stream: Api.getJoinedMeetingData(),
            builder: (context, snapshot){
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                // return const Center(
                //   child: CircularProgressIndicator(),
                // );
                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;
                  list = data?.map((e) => Meeting.fromJson(e.data())).toList() ??
                      [];
                  print("#length :  ${list.length}");
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: list.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return MeetingCard(
                            meeting: list[index],
                          );
                        }),
                  );
              }

            }),
      ),
    );
  }
}
