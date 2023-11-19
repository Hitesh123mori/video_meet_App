import 'package:flutter/material.dart';
import 'package:zoom_clone/custom_widgets/button.dart';
import 'package:zoom_clone/effects/transition4.dart';
import 'package:zoom_clone/screens/home_screen.dart';

import '../../Pallate.dart';
import '../../custom_widgets/switch_container.dart';
import '../../custom_widgets/text_field.dart';
import '../splash_screen.dart';

class JoinMeeting extends StatefulWidget {
  const JoinMeeting({super.key});

  @override
  State<JoinMeeting> createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  bool isSwitched = false ;


  @override
  void initState() {
    super.initState();

    // Add listeners to text controllers
    idController.addListener(updateButtonState);
    nameController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          idController.text.isNotEmpty && nameController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    idController.removeListener(updateButtonState);
    nameController.removeListener(updateButtonState);
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
              style: TextStyle(color: AppColors.theme['secondaryTextColor']),
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
                        ? () {
                            if (_formKey.currentState!.validate()) {}
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
                  SwitchContainer(text: "Connect To Audio", padding: 0.42,),
                  Divider(height: 0.5,),
                  SwitchContainer(text: "Off My Video", padding: 0.51,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
