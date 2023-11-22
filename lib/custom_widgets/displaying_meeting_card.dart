import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/models/meeting.dart';

class MeetingCard extends StatefulWidget {
  final Meeting meeting;

  const MeetingCard({Key? key, required this.meeting}) : super(key: key);

  @override
  State<MeetingCard> createState() => _MeetingCardState();
}

class _MeetingCardState extends State<MeetingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Meeting Name"),
              Text(widget.meeting.name),
            ],
          )
        ],
      ),
    );
  }
}
