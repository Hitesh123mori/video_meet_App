import 'package:flutter/material.dart' ;


class OptionContainer extends StatelessWidget {

  final Icon icon ;
  final String text ;
  final Color color ;

  const OptionContainer({super.key, required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){

          },
          child: Container(
            child: icon,
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        SizedBox(height: 5,),
        Text(text,style: TextStyle(fontSize: 12),),
      ],
    );
  }
}

