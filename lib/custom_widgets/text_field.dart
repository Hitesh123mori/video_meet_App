import 'package:flutter/material.dart';


class customField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isNumber;
  final FormFieldValidator<String>? validator;
  final String? intilatext ;

  const customField({
    Key? key,
    required this.hintText,
     this.controller,
    required this.isNumber,
    this.validator, this.intilatext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: mq.width * 1,
      height: 60,
      child: Center(
        child: TextFormField(
          initialValue: intilatext,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          controller: controller,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade600),
          ),
          validator: validator, // Use the validator
        ),
      ),
    );
  }
}

