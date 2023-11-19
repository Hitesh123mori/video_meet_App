import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';

class SwitchContainer extends StatefulWidget {
  final String  ? text ;
  final double  padding ;
  const SwitchContainer({super.key, required this.text, required this.padding});

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
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(widget.text!,style: TextStyle(fontSize: 17),),
            ),
            SizedBox(width: mq.width*widget.padding,),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                   isSwitched = value;
                });
              },
              activeTrackColor: Colors.blue.shade300,
              activeColor: Colors.blue,
            ),

          ],
        ),
        color: Colors.white,
        height: 60,
        width: double.infinity,
      ),
    );
  }
}
