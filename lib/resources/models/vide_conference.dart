import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import '../secrets.dart';

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;
  final bool isAudioOn;
  final bool isVideoOn;
  final bool isSpeakerOn;
  final String name;
  final String userId;
  final String profileImage ;

  const VideoConferencePage({
    Key? key,
    required this.conferenceID,
    required this.isAudioOn,
    required this.isVideoOn,
    required this.isSpeakerOn,
    required this.name,
    required this.userId, required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: Secrets.appid,
        appSign: Secrets.appsign,
        userID: userId,
        userName: name,
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(
          topMenuBarConfig : ZegoTopMenuBarConfig(style: ZegoMenuBarStyle.dark,title: "  MeetWith",hideAutomatically: true,),
          bottomMenuBarConfig: ZegoBottomMenuBarConfig(style: ZegoMenuBarStyle.dark,),
          turnOnCameraWhenJoining: isVideoOn,
          turnOnMicrophoneWhenJoining: isAudioOn,
          useSpeakerWhenJoining: isSpeakerOn,
          avatarBuilder: (BuildContext context, Size size, ZegoUIKitUser? user,
              Map extraInfo) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    profileImage
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
