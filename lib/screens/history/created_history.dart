import 'package:flutter/material.dart' ;
import 'package:zoom_clone/resources/models/meeting.dart';

import '../../custom_widgets/displaying_meeting_card.dart';
import '../../resources/Api.dart';

class Created extends StatefulWidget {
  const Created({super.key});

  @override
  State<Created> createState() => _CreatedState();
}

class _CreatedState extends State<Created> {

  List<Meeting> list = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder(
            stream: Api.getCreatedMeetingData(),
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
