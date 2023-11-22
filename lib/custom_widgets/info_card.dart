import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Icon icon ;
  final VoidCallback OnTap;
  final String text ;

  const InfoCard({super.key, required this.icon, required this.OnTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          IconButton(onPressed: OnTap, icon: icon),
        ],
      ),
    );
  }
}
