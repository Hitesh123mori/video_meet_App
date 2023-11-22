import 'package:flutter/material.dart';

import '../../resources/Api.dart';
import '../../resources/models/vide_conference.dart';

class NewMeeting extends StatefulWidget {
  const NewMeeting({super.key});

  @override
  State<NewMeeting> createState() => _NewMeetingState();
}

class _NewMeetingState extends State<NewMeeting> {
  @override
  Widget build(BuildContext context) {
    return  VideoConferencePage(
        conferenceID: Api.curUser!.meetingId,
        isAudioOn: Api.curUser!.isAudioConnect,
        isVideoOn: Api.curUser!.isVideoOn,
        isSpeakerOn: Api.curUser!.isSpeakerOn,
        name: Api.curUser!.name,
        userId: Api.curUser!.id,
        profileImage: Api.curUser!.image,
      );

  }
}
