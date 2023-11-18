import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final Color buttonColor;

  const customButton(
      {super.key,
        required this.onPressed,
        required this.text,
        required this.textColor,
        required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 7),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.1,
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
          ),
          minimumSize: Size(double.infinity, 50), // Set the desired height
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontFamily: "LatoBold",fontSize: 18),
        ),
      ),
    );
  }
}
