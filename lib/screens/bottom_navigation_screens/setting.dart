import 'package:flutter/material.dart' ;

import '../../resources/Api.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: (){
              Api.signOut(context);
            },
            child: Text("Signout"),
          ),
        ),
      ),
    );;
  }
}
