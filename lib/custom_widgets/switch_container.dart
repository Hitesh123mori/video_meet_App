import 'package:flutter/material.dart';

import '../Pallate.dart';
import '../screens/splash_screen.dart';

class SwitchContainer extends StatefulWidget {
  final String  ? text ;

  const SwitchContainer({super.key, required this.text});

  @override
  State<SwitchContainer> createState() => _SwitchContainerState();
}

class _SwitchContainerState extends State<SwitchContainer> {

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return Material(
      elevation: 2,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.text!,style: TextStyle(fontSize: 17),),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                     isSwitched = value;
                  });
                },
                activeTrackColor: Colors.blue.shade700,
                activeColor: AppColors.theme['primaryColor'],
              ),

            ],
          ),
        ),
        color: Colors.white,
        height: 60,
        width: double.infinity,
      ),
    );
  }
}
