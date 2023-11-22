import 'package:flutter/material.dart' ;

class authContainer extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String path ;

  const authContainer(
      {super.key,
        required this.onPressed,
        required this.text,
        required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 3),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.1,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
          ),
          minimumSize: Size(double.infinity, 50), // Set the desired height
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 13.0,bottom: 13),
              child: CircleAvatar(
                backgroundColor :Colors.white,
                backgroundImage: AssetImage(path),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.black, fontFamily: "LatoBold",fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
