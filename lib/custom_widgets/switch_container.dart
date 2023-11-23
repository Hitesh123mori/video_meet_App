import 'package:flutter/material.dart';

import '../Pallate.dart';
import '../screens/splash_screen.dart';

class SwitchContainer extends StatefulWidget {
  final String  ? text ;
   bool  isSwitched = false ;
   final ValueChanged<bool> onChanged;



   SwitchContainer({super.key, required this.text, required this.isSwitched, required this.onChanged});

  @override
  State<SwitchContainer> createState() => _SwitchContainerState();
}

class _SwitchContainerState extends State<SwitchContainer> {



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
                value: widget.isSwitched ,
                // onChanged: (value) {
                //   setState(() {
                //     widget.isSwitched = value;
                //   });
                // },
                onChanged: widget.onChanged,
                activeTrackColor: Colors.blue.shade700,
                activeColor: Colors.blue.shade900,
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
