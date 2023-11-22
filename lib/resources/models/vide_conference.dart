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
       //    onCameraTurnOnByOthersConfirmation: (BuildContext context) async {
       //   const textStyle = TextStyle(
       //     fontSize: 10,
       //    color: Colors.white70,
       //   );
       //   return await showDialog(
       //     context: context,
       //     barrierDismissible: false,
       //     builder: (BuildContext context) {
       //       return AlertDialog(
       //         backgroundColor: Colors.blue[900]!.withOpacity(0.9),
       //       title: const Text(
       //       'You have a request to turn on your camera',
       //       style: textStyle,
       //       ),
       //         content: const Text(
       //           'Do you agree to turn on the camera?',
       //           style: textStyle,
       //         ),
       //         actions: [
       //           ElevatedButton(
       //             child: const Text('Cancel', style: textStyle),
       //             onPressed: () => Navigator.of(context).pop(false),
       //          ),
       //           ElevatedButton(
       //             child: const Text('OK', style: textStyle),
       //             onPressed: () {
       //               Navigator.of(context).pop(true);
       //             },
       //           ),
       //         ],
       //       );
       //     },
       //  );
       // },
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
