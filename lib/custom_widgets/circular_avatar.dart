import 'package:flutter/material.dart';
import 'package:zoom_clone/Pallate.dart';

class customCircularAvatar extends StatelessWidget {

  final double radius ;
  final Icon icon ;
  final String text ;
  const customCircularAvatar({super.key, required this.radius, required this.icon, required this.text,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0,left: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.theme['secondaryColor'],
            radius: radius,
            child: Center(
              child: icon
            ),
          ),
          SizedBox(height: 3,),
          Text(text,style: TextStyle(color: AppColors.theme['primaryTextColor'],fontSize: 7),)
        ],
      ),
    );
  }
}
