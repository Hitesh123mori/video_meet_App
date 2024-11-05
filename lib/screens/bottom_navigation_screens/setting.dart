import 'package:flutter/material.dart';
import 'package:zoom_clone/Pallate.dart';
import 'package:zoom_clone/custom_widgets/button.dart';
import 'package:zoom_clone/effects/transition4.dart';
import 'package:zoom_clone/resources/Api.dart';
import '../../custom_widgets/switch_container.dart';
import '../../custom_widgets/text_field.dart';
import '../setting_screens/profile.dart';
import '../splash_screen.dart';

class Setting extends StatefulWidget {
  const Setting({
    super.key,
  });

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isAudio = Api.curUser!.isAudioConnect;

  bool isVideo = Api.curUser!.isVideoOn;

  bool isSpeaker = Api.curUser!.isSpeakerOn;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Api.getSelfData(Api.user.uid);
  }

  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Form(
        key: _formKey,
        child: Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    color: Colors.grey.shade100,
                    elevation: 0,
                    child: ListTile(
                      title: Text(Api.curUser!.name),
                      subtitle: Text(Api.curUser!.email),
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("assets/images/student.png"),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context, SizeTransition4(Profile()));
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          size: 32,
                        ),
                      ),
                    ),
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
                    text: "On Speaker",
                    isSwitched: isSpeaker,
                    onChanged: (bool value) {
                      setState(() {
                        isSpeaker = value;
                      });
                    },
                  ),
                  Container(
                    color: Colors.grey.shade100,
                    height: 60,
                    width: mq.width * 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Text(
                        "This name is default display in every meeting",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                  customField(
                    onSaved: (val) {
                      Api.curUser!.name = val ?? '' ;
                    },
                    hintText: 'Enter Name',
                    intilatext: Api.curUser!.name,
                    isNumber: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  customButton(
                    onPressed: ()async {
                      _formKey.currentState?.save();
                      await Api.updateJoinOptions(Api.curUser!.name, isAudio, isVideo, isSpeaker);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated Details")));

                    },
                    text: 'Save Changes',
                    textColor: AppColors.theme['primaryTextColor'],
                    buttonColor: AppColors.theme['primaryColor'],
                  ),
                ],
              ),
            )),
      ),
    );
    ;
  }
}
