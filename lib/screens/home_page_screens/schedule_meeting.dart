import 'package:flutter/material.dart';
import 'package:zoom_clone/custom_widgets/user_card.dart';
import 'package:zoom_clone/effects/Transition1.dart';
import 'package:zoom_clone/screens/home_page_screens/select_participates.dart';
import '../../Pallate.dart';
import '../../custom_widgets/button.dart';
import '../../custom_widgets/contact_card.dart';
import '../../custom_widgets/text_field.dart';
import '../../custom_widgets/text_field2.dart';
import '../../effects/transition4.dart';
import '../../resources/Api.dart';
import '../../resources/models/user.dart';
import '../home_screen.dart';
import '../splash_screen.dart';

class ScheduledMeeting extends StatefulWidget {
  const ScheduledMeeting({super.key});

  @override
  State<ScheduledMeeting> createState() => _ScheduledMeetingState();
}

class _ScheduledMeetingState extends State<ScheduledMeeting> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController dateController  = TextEditingController() ;

  bool isButtonEnabled = false;
  DateTime? selectedDateTime;

  bool isSearching = false ;



  @override
  void initState() {
    super.initState();
    selectedDateTime = DateTime.now();
    nameController.addListener(updateButtonState);
    passController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          nameController.text.isNotEmpty && passController.text.isNotEmpty ;
    });
  }

  @override
  void dispose() {
    nameController.removeListener(updateButtonState);
    passController.removeListener(updateButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
            "Upcoming Meeting",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.theme['secondaryTextColor']),
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
                  hintText: 'Create Meeting Password',
                  controller: passController,
                  isNumber: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Your Password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: mq.width * 0.7,
                      child: textField(
                        controller: dateController,
                        hintText: 'Pick Meeting Date and Time : ',
                        isNumber: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pick Date and Time';
                          }
                          return null;
                        },
                      ),
                    ),
                    GestureDetector(
                    onTap: _selectDateTime,
                      child: Container(
                        child: IconButton(
                            onPressed:_selectDateTime,
                            icon: Icon(
                              Icons.today,
                              color: AppColors.theme['primaryColor'],
                            )),
                        height: 60,
                        width: mq.width * 0.3,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {
                     Navigator.push(context, SizeTransition1(SelectPartcipate()));
                    },
                    child: Text("Select Participants Tap Here",style: TextStyle(color: AppColors.theme['primaryColor']),)
                ),
                customButton(
                  onPressed: isButtonEnabled
                      ? () async{
                    if (_formKey.currentState!.validate()) {

                      await Api.createUpcomingMeeting(nameController.text,passController.text,selectedFinalUsers,dateController.text).then((value) {
                         Navigator.pushReplacement(context, SizeTransition4(HomeScreen()));
                      }) ;

                    }
                  }
                      : () {}, // An empty callback if the button is disabled
                  text: 'Add Meeting Timer',
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
      ),
    );
  }




  Future<void> _selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime!,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime!),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
      dateController.text = selectedDateTime!.toString();
    }
  }

}
