import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';


class CustomUserInfoCard extends StatelessWidget {
  final String header ;
  final String text ;

  const CustomUserInfoCard({super.key, required this.header, required this.text});

  @override
  Widget build(BuildContext context) {
    mq  =  MediaQuery.of(context).size ;
    return  Container(
      color: Colors.grey.shade200,
      height: 60,
      width: mq.width * 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
               header,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              Text(
                text,
                style: TextStyle(color: Colors.grey.shade600),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
