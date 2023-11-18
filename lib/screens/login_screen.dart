import 'package:flutter/material.dart';
import 'package:zoom_clone/pallate.dart';
import 'package:zoom_clone/screens/signin/sign_in.dart';
import 'package:zoom_clone/screens/signup/confirmation_signup.dart';
import 'package:zoom_clone/screens/splash_screen.dart';
import '../custom_widgets/button.dart';
import '../custom_widgets/circular_avatar.dart';
import '../effects/transition4.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          // backgroundColor: AppColors.theme['primaryColor'],
          body: Stack(
        children: [
          Container(
            color: AppColors.theme['primaryColor'],
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: mq.height * 0.35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Z",
                      style: TextStyle(
                          fontFamily: "LatoBold",
                          color: AppColors.theme['primaryTextColor'],
                          fontSize: 57),
                    ),
                    customCircularAvatar(
                      radius: 18,
                      icon: Icon(
                        Icons.chat_bubble,
                        size: 18,
                      ),
                      text: 'Team Chat',
                    ),
                    customCircularAvatar(
                      radius: 18,
                      icon: Icon(
                        Icons.call,
                        size: 18,
                      ),
                      text: 'Call',
                    ),
                    customCircularAvatar(
                      radius: 14,
                      icon: Icon(
                        Icons.video_call,
                        size: 20,
                      ),
                      text: 'Video',
                    ),
                    customCircularAvatar(
                      radius: 14,
                      icon: Icon(
                        Icons.meeting_room,
                        size: 18,
                      ),
                      text: 'Meetroom',
                    ),
                    customCircularAvatar(
                      radius: 18,
                      icon: Icon(
                        Icons.mail,
                        size: 18,
                      ),
                      text: 'Mail',
                    ),
                    customCircularAvatar(
                      radius: 18,
                      icon: Icon(
                        Icons.calendar_today_rounded,
                        size: 18,
                      ),
                      text: 'Calendar',
                    ),
                    Text(
                      "m",
                      style: TextStyle(
                          fontFamily: "LatoBold",
                          color: AppColors.theme['primaryTextColor'],
                          fontSize: 57),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: mq.height * 0.37,
                width: mq.width * 1,
                decoration: BoxDecoration(
                    color: AppColors.theme['secondaryColor'],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: mq.height * 0.04,
                      ),
                      Text(
                        "Welcome",
                        style: TextStyle(fontSize: 25, fontFamily: 'LatoBold'),
                      ),
                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      Text(
                        "Get started with your account",
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'LatoBold',
                            color: Colors.black38),
                      ),
                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      customButton(
                        onPressed: () {},
                        text: 'Join a Meeting',
                        textColor: AppColors.theme['primaryTextColor'],
                        buttonColor: AppColors.theme['primaryColor'],
                      ),
                      customButton(
                        onPressed: () {
                          Navigator.push(context, SizeTransition4(signUp()));
                        },
                        text: 'Sign Up',
                        textColor: AppColors.theme['secondaryTextColor'],
                        buttonColor: AppColors.theme['buttonColor2'],
                      ),
                      customButton(
                        onPressed: () {
                          Navigator.push(context, SizeTransition4(SignInOption()));

                        },
                        text: 'Sign In',
                        textColor: AppColors.theme['secondaryTextColor'],
                        buttonColor: AppColors.theme['buttonColor2'],
                      ),
                    ],
                  ),
                ),
              ))
        ],
      )),
    );
  }
}
