import 'package:flutter/material.dart';
import 'package:zoom_clone/custom_widgets/button.dart';
import 'package:zoom_clone/effects/transition4.dart';
import 'package:zoom_clone/resources/models/vide_conference.dart';
import 'package:zoom_clone/resources/my_custom_date.dart';
import 'package:zoom_clone/screens/home_screen.dart';

import '../../Pallate.dart';
import '../../custom_widgets/switch_container.dart';
import '../../custom_widgets/text_field.dart';
import '../../resources/Api.dart';
import '../../resources/models/user.dart';
import '../splash_screen.dart';


class JoinMeeting extends StatefulWidget {
  const JoinMeeting({super.key});

  @override
  State<JoinMeeting> createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  bool isAudio = Api.curUser!.isAudioConnect;

  bool isVideo = Api.curUser!.isVideoOn;

  bool isSpeaker = Api.curUser!.isSpeakerOn;

  @override
  void initState() {
    super.initState();

    // Add listeners to text controllers
    idController.addListener(updateButtonState);
    nameController.addListener(updateButtonState);
    passController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          idController.text.isNotEmpty && nameController.text.isNotEmpty && passController.text.isNotEmpty ;
    });
  }

  @override
  void dispose() {
    idController.removeListener(updateButtonState);
    nameController.removeListener(updateButtonState);
    passController.removeListener(updateButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: AppColors.theme['secondaryTextColor'],
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, SizeTransition4(HomeScreen()));
                },
              ),
            ),
            elevation: 0.2,
            centerTitle: true,
            title: Text(
              "Join Meeting",
              style: TextStyle(fontWeight : FontWeight.bold ,color: AppColors.theme['secondaryTextColor']),
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  customField(
                    hintText: 'Meeting Id',
                    controller: idController,
                    isNumber: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Meeting Id';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  customField(
                    hintText: 'Meeting Password',
                    controller: passController,
                    isNumber: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Meeting Password';
                      }
                      return null;
                    },
                  ),
                  Container(
                    color: Colors.grey.shade100,
                    height: 60,
                    width: mq.width * 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 22,
                        horizontal: 20,
                      ),
                      child: Text(
                        "ENTER YOUR NAME",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                  customField(
                    // intilatext:Api.curUser!.name,
                    hintText: 'Enter Name',
                    controller: nameController,
                    isNumber: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  customButton(
                    onPressed: isButtonEnabled
                        ? () async {
                            if (_formKey.currentState!.validate()) {

                              await Api.joinMeeting(await Api.fetchMeetingDataJoinedByAttribute(idController.text,context)?? MeetUser(image: "", name: "", createdAt: "", id:
                              "", email: "", method: "", meetingId: "", isAudioConnect: false, isSpeakerOn: false, isVideoOn:false),passController.text,context).then((value) {


                                Navigator.push(
                                          context,
                                          SizeTransition4(VideoConferencePage(
                                            conferenceID: idController.text,
                                            isAudioOn: isAudio,
                                            isVideoOn: isVideo,
                                            isSpeakerOn: isSpeaker,
                                            name: nameController.text,
                                            userId: Api.curUser!.id,
                                            profileImage: Api.curUser!.image,
                                          )));


                              });

                            }
                          }
                        : () {},
                    text: 'Join a Meeting',
                    textColor: isButtonEnabled
                        ? AppColors.theme['primaryTextColor']
                        : Colors.grey.shade600,
                    buttonColor: isButtonEnabled
                        ? AppColors.theme['primaryColor']
                        : AppColors.theme['buttonColor2'],
                  ),
                  Container(
                    color: Colors.grey.shade100,
                    height: 60,
                    width: mq.width * 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 22,
                        horizontal: 20,
                      ),
                      child: Text(
                        "JOIN OPTIONS",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                  SwitchContainer(
                    text: "Connect To Audio",
                    isSwitched: isAudio,
                    onChanged: (bool value) {
                      setState(() {
                        isAudio = value;
                      });
                    },
                  ),
                  Divider(
                    height: 0.5,
                  ),
                  SwitchContainer(
                    text: "On My Video",
                    isSwitched: isVideo,
                    onChanged: (bool value) {
                      setState(() {
                        isVideo = value;
                      });
                    },
                  ),
                  Divider(
                    height: 0.5,
                  ),
                  SwitchContainer(
                    text: "On My Speaker",
                    isSwitched: isSpeaker,
                    onChanged: (bool value) {
                      setState(() {
                        isSpeaker = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
