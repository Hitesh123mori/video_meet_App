import 'dart:async';

import 'package:flutter/material.dart';

import '../resources/models/meeting.dart';

class UpcomingTimer extends StatefulWidget {
  final Meeting meeting;
  const UpcomingTimer({super.key, required this.meeting});

  @override
  State<UpcomingTimer> createState() => _UpcomingTimerState();
}

class _UpcomingTimerState extends State<UpcomingTimer> {
  Timer? timer;
  Duration? remainingTime;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        final now = DateTime.now();

        DateTime meetingDate = DateTime.parse(widget.meeting.date);
        print("meetingDate : ${meetingDate}");

        remainingTime = meetingDate.isAfter(now)
            ? meetingDate.difference(now)
            : Duration(seconds: 0);

        print("remainingTime : ${remainingTime}");
      });

      if (remainingTime!.inSeconds == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      child: ListTile(
        trailing: TextButton(
          onPressed: (){},
          child: Text("Details"),
        ),
        title: Text(widget.meeting.name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
        subtitle: Text(
          'Meeting Starts in : ${remainingTime?.inHours ?? 0}h ${remainingTime?.inMinutes.remainder(60) ?? 0}m ${remainingTime?.inSeconds.remainder(60) ?? 0}s',
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
