import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/models/meeting.dart';
import 'package:zoom_clone/resources/my_custom_date.dart';
import '../screens/splash_screen.dart';


class MeetingCard extends StatefulWidget {
  final Meeting meeting;

  const MeetingCard({Key? key, required this.meeting}) : super(key: key);

  @override
  State<MeetingCard> createState() => _MeetingCardState();
}

class _MeetingCardState extends State<MeetingCard> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          buildRow("Meeting Name", widget.meeting.name),
          buildRow("Meeting Host", widget.meeting.hostName),
          buildRow("Host Email", widget.meeting.hostEmail),
          buildRow("Meeting ID", widget.meeting.meetingId),
          buildRow("Meeting Date", MyDateUtil.getFormattedTime3(context: context, time: widget.meeting.date, showYear: true)),
        ],
      ),
    );
  }

  Widget buildRow(String title, String content) {
    return Container(
      color: Colors.grey.shade200,
      height: 40,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            Flexible(
              child: Text(
                content,
                style: TextStyle(color: Colors.grey.shade600),
                overflow: TextOverflow.ellipsis, // Add this line to handle overflow
              ),
            ),
          ],
        ),
      ),
    );
  }
}

