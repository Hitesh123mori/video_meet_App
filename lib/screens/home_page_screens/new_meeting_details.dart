import 'package:flutter/material.dart';

import '../../Pallate.dart';
import '../../custom_widgets/CustomUserInfoCard.dart';
import '../../custom_widgets/button.dart';
import '../../custom_widgets/text_field.dart';
import '../../effects/transition4.dart';
import '../../resources/Api.dart';
import '../../resources/models/vide_conference.dart';
import '../home_screen.dart';
import '../splash_screen.dart';
import 'new_meeting.dart';

class MeetingDetails extends StatefulWidget {
  const MeetingDetails({super.key});

  @override
  State<MeetingDetails> createState() => _MeetingDetailsState();
}

class _MeetingDetailsState extends State<MeetingDetails> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  TextEditingController nameController = TextEditingController() ;
  TextEditingController passController = TextEditingController() ;



  bool isButtonEnabled = false;



  @override
  void initState() {
    super.initState();
    nameController.addListener(updateButtonState) ;
    passController.addListener(updateButtonState) ;
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          nameController.text.isNotEmpty && passController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    nameController.removeListener(updateButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mq  = MediaQuery.of(context).size;
    return Scaffold(
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
          "New Meeting",
          style: TextStyle(fontWeight : FontWeight.bold ,color: AppColors.theme['secondaryTextColor']),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(

            children: [
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
                    "ENTER MEETING NAME",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ),
              customField(
                // intilatext:Api.curUser!.name,
                hintText: 'Enter Meeting Name',
                controller: nameController,
                isNumber: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Your Name';
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
                    "CREATE MEETING PASSWORD",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ),
              customField(
                // intilatext:Api.curUser!.name,
                hintText: 'Meeting Password',
                controller: passController,
                isNumber: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  final passwordRegex = RegExp(r'^(?=.*[!@#\$%^&*])(?=.*[a-z])(?=.*[A-Z]).{6,}$');
                  if (!passwordRegex.hasMatch(value)) {
                    return 'Password must contain at least one special character, one lowercase letter, and one uppercase letter';
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
                    "MEETING DETAILS",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ),
              CustomUserInfoCard(header: 'Host Name', text: Api.curUser!.name,),
              CustomUserInfoCard(header: 'Host Email', text: Api.curUser!.email,),
              CustomUserInfoCard(header: 'Meeting ID', text: Api.curUser!.meetingId.replaceAllMapped(
                RegExp(r".{4}"),
                    (match) => "${match.group(0)} ",
              ),),
              CustomUserInfoCard(header: 'Meeting Date', text: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",),
              SizedBox(
                height: mq.height * 0.02,
              ),
              customButton(
                onPressed: isButtonEnabled
                    ? () async {
                  if (_formKey.currentState!.validate()) {

                   await  Api.createMeeting(nameController.text,passController.text).then((value) {

                     Navigator.push(
                         context,
                         SizeTransition4(
                             NewMeeting()));

                   }) ;
                  }
                }
                    : () {},
                text: 'Start Meeting',
                textColor: isButtonEnabled
                    ? AppColors.theme['primaryTextColor']
                    : Colors.grey.shade600,
                buttonColor: isButtonEnabled
                    ? AppColors.theme['primaryColor']
                    : AppColors.theme['buttonColor2'],
              ),
            ],

          ),
        ),
      ),
    );
  }
}
